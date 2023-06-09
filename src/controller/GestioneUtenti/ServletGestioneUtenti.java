package controller.GestioneUtenti;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

public class ServletGestioneUtenti extends HttpServlet{
	
private static final long serialVersionUID = 1L;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
			}
		}
		this.getServletContext().getRequestDispatcher("/gestione-utenti.jsp").forward(request, response);
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String button = request.getParameter("");
	}

}
