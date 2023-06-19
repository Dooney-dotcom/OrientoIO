package controller.Autenticazione;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

public class ServletAutenticazione extends HttpServlet{
	
private static final long serialVersionUID = 1L;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username"); 
		String password = request.getParameter("password");
		
		if(username == null || password == null) {
			this.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
		}else {
			DatabaseMock db = (DatabaseMock) this.getServletContext().getAttribute("db");
			Map<String, Account> accounts = db.getAccounts();
			Map<String, StudenteUniversitario> studenti = db.getStudenti();
			Map<String, Utente> utenti = db.getUtenti();
			
			//Caso Admin
			if(username.startsWith("admin")) {
				if(accounts.containsKey(username)) {
					//La pagina di gestione utenti diventerà una jsp
					if(password.equals(accounts.get(username).getPassword())) {
						request.getSession().setAttribute("user", accounts.get(username));
						request.getSession().setAttribute("username", username);
						request.getSession().setAttribute("ruolo", "amministratore");
						this.getServletContext().getRequestDispatcher("/HomeAmministratore.jsp").forward(request, response);
					}else {
						request.getSession().setAttribute("errorLogin", "Password sbagliata. Riprova.");
						this.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
					}
				}else {
					request.getSession().setAttribute("errorLogin", "Username sbagliato. Riprova.");
					this.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
				}
			}else {
				if(accounts.containsKey(username)) {
					if(accounts.get(username).getPassword().equals(password)) {
						//Caso Studente
						if(studenti.containsKey(username)) {
							request.getSession().setAttribute("user", studenti.get(username));
							request.getSession().setAttribute("ruolo", "studente");
							request.getSession().setAttribute("username", username);
							System.out.println("STUDENTE: "+studenti.get(username).getUsername());
							this.getServletContext().getRequestDispatcher("/homepage-studente.jsp").forward(request, response);
						}//Caso Utente
						else if(utenti.containsKey(username)) {
							request.getSession().setAttribute("user", utenti.get(username));
							request.getSession().setAttribute("ruolo", "utente");
							request.getSession().setAttribute("username", username);
							System.out.println("UTENTE: "+utenti.get(username).getUsername());
							this.getServletContext().getRequestDispatcher("/homepage-utente.jsp").forward(request, response);
						}
					}else {
						request.getSession().setAttribute("errorLogin", "Password sbagliata. Riprova.");
						this.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
					}
				}else {
					request.getSession().setAttribute("errorLogin", "Username sbagliato. Riprova.");
					this.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
				}
			}
		}
	}

}
