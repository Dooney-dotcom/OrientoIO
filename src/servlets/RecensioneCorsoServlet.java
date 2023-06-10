package servlets;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;
import util.RecensioneCorsoResult;
import util.recensioneCorsoRequest;

import java.util.*;

public class RecensioneCorsoServlet extends HttpServlet{

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	Gson gson;

    @Override
    public void init() throws ServletException {
        gson = new Gson();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	if(getServletContext().getAttribute("db") == null){
    		DatabaseMock db = new DatabaseMock();
    		getServletContext().setAttribute("db", db);
    	}

    	DatabaseMock db = (DatabaseMock) getServletContext().getAttribute("db");
    	
        StudenteUniversitario s = (StudenteUniversitario) request.getSession().getAttribute("user");
        if(s == null) {
            response.sendRedirect("login.jsp");
        }

        String jsonData = request.getReader().lines().collect(Collectors.joining());
        
        recensioneCorsoRequest recensione = this.gson.fromJson(jsonData, recensioneCorsoRequest.class);  //otteniamo la recensioneRequest 
        
        RecensioneCorsoResult result = new RecensioneCorsoResult();
        
        //ora distinguiamo i casi di elimina da invia/modifica
        if(recensione.getMessage().equals("elimina")) {
        	
        	db.getStudenti().get(s.getUsername()).setRecensioneCorso(null);
        	
        	db.getRecensioniCorso().remove(s.getRecensioneCorso());
        	
        	List<SegnalazioneRecensioneCorso> segnalazioni = db.getSegnalazioniCorso();
        	for(SegnalazioneRecensioneCorso sr : segnalazioni) {
        		if(sr.getRecensioneSegnalata().getStudente().equals(s)) {
        			db.getSegnalazioniCorso().remove(sr);
        		}
        	}
        	
        	System.out.println("recensione: " + recensione + " eliminata");
        	result.setMessage("eliminazione completata");
        }else {
        	//in questo caso lo studente sta inviando o modificando la sua recensione
        	RecensioneCorso rc = new RecensioneCorso();
        	rc.setStudente(s);
        	rc.setTestoRecensione(recensione.getTestoRecensione());
        	rc.setOpportunitaOfferte(recensione.getOpportunitaOfferte());
        	rc.setQualitaInsegnamento(recensione.getQualitaInsegnamento());
        	rc.setSbocchiLavorativi(recensione.getSbocchiLavorativi());
        	rc.setCorso(s.getPianoFormativo().getCorso());
        	
        	//per il db distinguiamo i casi in cui sia la prima volta che la invia o la stia modificando
        	for(RecensioneCorso r : db.getRecensioniCorso()) {
        		if(r.getStudente().getUsername().equals(s.getUsername())) { // se gia esiste una recensione scritta dallo studente
        			db.getRecensioniCorso().remove(r); //eliminiamo la vecchia recensione
        			break;
        		}
        	}
        	
        	db.getRecensioniCorso().add(rc);
    		
    		db.getStudenti().get(s.getUsername()).setRecensioneCorso(rc);
        	
    		s.setRecensioneCorso(rc);
    		request.getSession().setAttribute("user", s);
    		
        	result.setMessage("ok");
        	result.setTestoRecensione(recensione.getTestoRecensione());
        	result.setOpportunitaOfferte(recensione.getOpportunitaOfferte());
        	result.setSbocchiLavorativi(recensione.getSbocchiLavorativi());
        	result.setQualitaInsegnamento(recensione.getQualitaInsegnamento());
        	
        	System.out.println("recensione: " + recensione + " inviata");
        }
        
        String jsonResponse = gson.toJson(result);
        // Imposta l'intestazione della risposta come JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Invia la risposta al JavaScript
        response.getWriter().write(jsonResponse);
    }
}