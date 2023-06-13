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

	private DatabaseMock database;
	private Gson gson;
	private GsonBuilder gsonBuilder;
		
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		
		 this.gsonBuilder = new GsonBuilder();
	     //gsonBuilder.registerTypeAdapter(LocalDate.class, new LocalDateSerializer());

	    // gsonBuilder.registerTypeAdapter(LocalDateTime.class, new LocalDateTimeSerializer());

	     //gsonBuilder.registerTypeAdapter(LocalDate.class, new LocalDateDeserializer());

	     //gsonBuilder.registerTypeAdapter(LocalDateTime.class, new LocalDateTimeDeserializer());
	        
	    // gsonBuilder.registerTypeAdapter(Duration.class, new DurationSerializer());

	     //gsonBuilder.registerTypeAdapter(Duration.class, new DurationDeserializer());
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
			this.getServletContext().getRequestDispatcher("/registrazione.jsp").forward(request, response);
		}else {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate birthdate = LocalDate.parse(request.getParameter("Data"), formatter);
			DatabaseMock db = (DatabaseMock) this.getServletContext().getAttribute("db");
			Map<String, Account> accounts = db.getAccounts();
			Map<String, StudenteUniversitario> studenti = db.getStudenti();
			Map<String, Utente> utenti = db.getUtenti();
			
			if(accounts.containsKey(username)) {
				this.getServletContext().getRequestDispatcher("/registrazione.jsp").forward(request, response);
			}else {
				Account a = new Account();
				a.setUsername(username);
				a.setPassword(password);
				
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
					a.setRuolo("studente");
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
