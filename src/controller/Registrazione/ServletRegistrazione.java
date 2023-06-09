package controller.Registrazione;

import java.io.IOException;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

public class ServletRegistrazione extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private DatabaseMock database;
		
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}
		
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("Nome");
		String surname = request.getParameter("Cognome");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate birthdate = LocalDate.parse(request.getParameter("Data"), formatter);
		String username = request.getParameter("Username"); 
		String password = request.getParameter("Password");
		
		if(name == null || surname == null || username == null || password == null || request.getParameter("Data") == null) {
			this.getServletContext().getRequestDispatcher("/registrazione.html").forward(request, response);
		}else {
			DatabaseMock db = (DatabaseMock) this.getServletContext().getAttribute("db");
			Map<String, Account> accounts = db.getAccounts();
			Map<String, StudenteUniversitario> studenti = db.getStudenti();
			Map<String, Utente> utenti = db.getUtenti();
			
			if(accounts.containsKey(username)) {
				this.getServletContext().getRequestDispatcher("/registrazione.html").forward(request, response);
			}else {
				Account account = new Account();
				account.setPassword(password);
				accounts.put(username, account);
				
				String citta = request.getParameter("cit");
				String uni = request.getParameter("uni");
				String corso = request.getParameter("co");
				String piano = request.getParameter("pi");
				
				if(citta != null && uni != null && corso != null && piano != null) {
					StudenteUniversitario s = new StudenteUniversitario();
					s.setNome(name);
					s.setCognome(surname);
					s.setDataDiNascita(birthdate);
					s.setUsername(username);
					
					CittaUniversitaria c = new CittaUniversitaria();
					c.setNomeCitta(citta);
					
					Universita un = new Universita();
					un.setNome(uni);
					un.setCitta(c);
					
					CorsoDiLaurea cor = new CorsoDiLaurea();
					cor.setClasseDiCorso(corso);
					cor.setUniversita(un);
					
					PianoFormativo p = new PianoFormativo();
					p.setAnnoImmatricolazione(piano);
					p.setCorso(cor);
					
					s.setCitta(c);
					s.setPianoFormativo(p);
					
					studenti.put(username, s);
					db.setStudenti(studenti);
				}else {
					Utente u = new Utente();
					u.setNome(name);
					u.setCognome(surname);
					u.setDataDiNascita(birthdate);
					u.setUsername(username);
					
					utenti.put(username, u);
					db.setUtenti(utenti);
				}
				
				db.setAccounts(accounts);
				this.getServletContext().setAttribute("db", db);
				this.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
			}
		}
	}
}
