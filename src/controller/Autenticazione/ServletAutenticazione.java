package controller.Autenticazione;

import java.io.IOException;

import java.util.Map;

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
			if(username.equals("admin") && password.equals("admin")) {
				//La pagina di gestione utenti diventerà una jsp
				this.getServletContext().getRequestDispatcher("/gestione-utenti.jsp").forward(request, response);
			}else {
				if(accounts.containsKey(username)) {
					if(accounts.get(username).getPassword().equals(password)) {
						//Caso Studente
						if(studenti.containsKey(username)) {
							this.getServletContext().setAttribute("stud", studenti.get(username));
							this.getServletContext().getRequestDispatcher("/homepage-studente.jsp").forward(request, response);
						}//Caso Utente
						else if(utenti.containsKey(username)) {
							this.getServletContext().setAttribute("user", utenti.get(username));
							this.getServletContext().getRequestDispatcher("/homepage-utente.jsp").forward(request, response);
						}
					}else {
						this.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
					}
				}else {
					this.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
				}
			}
		}
	}

}
