package controller.GestioneUtenti;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;

public class ServletGestioneUtenti extends HttpServlet{
	
private static final long serialVersionUID = 1L;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DatabaseMock db = (DatabaseMock) this.getServletContext().getAttribute("db");
		Map<String, StudenteUniversitario> studenti = db.getStudenti();
		
		String button = request.getParameter("b");
		String target = request.getParameter("target"); 
		String r = request.getParameter("r");
		String d = request.getParameter("d");
		
		StudenteUniversitario s = studenti.get(target);
		
		//Caso Applica
		if(button.equals("applica")) {
			Restrizione restr = new Restrizione();
			if(r.equals("ban")) {
				restr.setTipoRestrizione(TipoRestrizione.BAN);
			}else if(r.equals("scrittura")) {
				restr.setTipoRestrizione(TipoRestrizione.SCRITTURA);
			}
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			if(LocalDate.parse(d, formatter).getYear() >= LocalDate.now().getYear()) {
				if(LocalDate.parse(d, formatter).getMonthValue() >= LocalDate.now().getMonthValue()) {
					if(LocalDate.parse(d, formatter).getDayOfMonth() >= LocalDate.now().getDayOfMonth()) {
						restr.setScadenza(LocalDateTime.of(LocalDate.parse(d, formatter), LocalTime.now()));
						s.setRestrizione(restr);
					}else {
						s.setRestrizione(null);
					}
				}else {
					s.setRestrizione(null);
				}
			}else {
				s.setRestrizione(null);
			}	
		}else //Caso Rimuovi
			if(button.equals("rimuovi")) {
				s.setRestrizione(null);
			}
		db.setStudenti(studenti);
		this.getServletContext().setAttribute("db", db);
		Gson g = new Gson();
		response.getWriter().write(g.toJson(""));
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Restituisce la lista con gli utenti/l'utente ricercato
		String word = request.getParameter("word");
		if(word != null) {
			DatabaseMock db = (DatabaseMock) this.getServletContext().getAttribute("db");
			Map<String, StudenteUniversitario> studenti = db.getStudenti();
			Map<String, StudenteUniversitario> studentiCercati = new HashMap<>();
			
			//Creazione for per scorrere le key della mappa STUDENTI
			for(String user: studenti.keySet()) {
				if(user.startsWith(word) || user.equals(word)) {
					studentiCercati.put(user, studenti.get(user));
				}
			}
			
			if(!studentiCercati.isEmpty()) {
				this.getServletContext().setAttribute("ricerca", studentiCercati);
			}else {
				this.getServletContext().setAttribute("ricerca", studenti);
			}
		}
		this.getServletContext().getRequestDispatcher("/gestione-utenti.jsp").forward(request, response);
	}
}
