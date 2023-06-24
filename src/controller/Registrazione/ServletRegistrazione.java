package controller.Registrazione;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import model.*;
import util.CorsoResult;
import util.EsameResult;
import util.PianoFormativoResult;
import util.UniversitaResult;

public class ServletRegistrazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Gson gson;
	private GsonBuilder gsonBuilder;
		
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		 this.gsonBuilder = new GsonBuilder();
	     this.gson = gsonBuilder.setPrettyPrinting().create();
	}
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* Utilizzata per restituire la lista di università e corsi in base alla città */

		String c = request.getParameter("name");
		if(c == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		DatabaseMock db = (DatabaseMock) this.getServletContext().getAttribute("db");
		CittaUniversitaria citta = db.getCitta().get(c);

		if(citta == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		List<Universita> universita = new ArrayList<>();

		db.getUniversita().keySet().forEach(key -> {
			if(db.getUniversita().get(key).getCitta().getNomeCitta().equals(c)) {
				universita.add(db.getUniversita().get(key));
			}
		});

		List<UniversitaResult> result = new ArrayList<>();

		universita.forEach(u -> {
			UniversitaResult r = new UniversitaResult();
			r.setNome(u.getNome());
			u.getCorsiDiLaurea().forEach(cdl -> {
				CorsoResult cr = new CorsoResult();
				cr.setName(cdl.getNome());
				cdl.getPianiFormativi().forEach(pf -> {
					PianoFormativoResult pr = new PianoFormativoResult();
					pr.setName(pf.getAnnoImmatricolazione());
					pf.getEsami().forEach(e -> {
						EsameResult er = new EsameResult();

						er.setNome(e.getNome());
            			er.setAnno(e.getAnno());
            			er.setCFU(e.getCFU());
            			er.setLinkEsame(e.getLinkEsame());
            			er.setPeriodo(e.getPeriodo());
            			er.setSSD(e.getSSO());
            			
            			pr.getEsami().add(er);
					});
					cr.getPiani().add(pr);
				});
				r.getCorsi().add(cr);
			});
			result.add(r);
		});

		response.getWriter().write(gson.toJson(result));
	}
		
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("Nome");
		String surname = request.getParameter("Cognome");
		String username = request.getParameter("Username"); 
		String password = request.getParameter("Password");
		
		if(name == "" || surname == "" || username == "" || password == "" || request.getParameter("Data") == "") {
			request.getSession().setAttribute("errore", "Campi mancanti.");
			this.getServletContext().getRequestDispatcher("/registrazione.jsp").forward(request, response);
		}else {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate birthdate = LocalDate.parse(request.getParameter("Data"), formatter);
			if(LocalDate.now().getYear()-birthdate.getYear() < 18) {
				request.getSession().setAttribute("errore", "Non sei maggiorenne. Inserisci una data valida.");
				this.getServletContext().getRequestDispatcher("/registrazione.jsp").forward(request, response);
			}
			DatabaseMock db = (DatabaseMock) this.getServletContext().getAttribute("db");
			Map<String, Account> accounts = db.getAccounts();
			Map<String, StudenteUniversitario> studenti = db.getStudenti();
			Map<String, Utente> utenti = db.getUtenti();
			
			if(accounts.containsKey(username)) {
				request.getSession().setAttribute("errore", "Username già in uso. Provane un altro.");
				this.getServletContext().getRequestDispatcher("/registrazione.jsp").forward(request, response);
			}else {
				Account a = new Account();
				a.setUsername(username);
				a.setPassword(password);
				
				String citta = request.getParameter("city");
				String uni = request.getParameter("university");
				String corso = request.getParameter("course");
				String piano = request.getParameter("piano");
				
				if(citta != null || uni != null || corso != null || piano !=null) {
					
					Map<String, CittaUniversitaria> cittas = db.getCitta();
					Map<String, Universita> universita = db.getUniversita();
					List<CorsoDiLaurea> corsi = db.getCorsi();
					
					if(citta != null && uni != null && corso != null && piano != null) {
						StudenteUniversitario s = new StudenteUniversitario();
						s.setNome(name);
						s.setCognome(surname);
						s.setDataDiNascita(birthdate);
						s.setUsername(username);
						
						//Citta
						CittaUniversitaria c = cittas.get(citta);
						
						//Piano Formativo 
						PianoFormativo p = null;
						for(CorsoDiLaurea cc: corsi) {
							if(cc.getUniversita().getCitta().getNomeCitta().equals(citta) && cc.getUniversita().getNome().equals(uni)) {
								if(cc.getNome().equals(corso)) {
									for(PianoFormativo pf: cc.getPianiFormativi()) {
										if(pf.getAnnoImmatricolazione().equals(piano)) {
											p = pf;
										}
									}
								}
							}
						}
						
						if(p != null && c != null) {
							s.setCitta(c);
							s.setPianoFormativo(p);
							
							studenti.put(username, s);
							db.setStudenti(studenti);
							a.setRuolo("studente");
							
							List<StudenteUniversitario> cit = c.getStudenti();
							cit.add(s);
							c.setStudenti(cit);

						}else {
							request.getSession().setAttribute("errore", "Server error.");
							this.getServletContext().getRequestDispatcher("/registrazione.jsp").forward(request, response);
						}
					}else {
						request.getSession().setAttribute("errore", "Campi mancanti per essere uno Studente.");
						this.getServletContext().getRequestDispatcher("/registrazione.jsp").forward(request, response);
					}
				}else {
					Utente u = new Utente();
					u.setNome(name);
					u.setCognome(surname);
					u.setDataDiNascita(birthdate);
					u.setUsername(username);
					
					utenti.put(username, u);
					db.setUtenti(utenti);
					a.setRuolo("utente");
				}
				
				accounts.put(username, a);
				db.setAccounts(accounts);
				this.getServletContext().setAttribute("db", db);
				this.getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
			}
		}
	}
}
