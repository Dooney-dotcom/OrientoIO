package servlets;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;

public class ServletConvalida extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DatabaseMock db = (DatabaseMock) this.getServletContext().getAttribute("db");
		Map<String, StudenteUniversitario> studenti = db.getStudenti();
		List<InformazioniCitta> info = db.getInfoCitta();
		
		String button = request.getParameter("b");
		String target = request.getParameter("target"); 
		
		StudenteUniversitario s = studenti.get(target);
		InformazioniCitta si = null;
		
		for(InformazioniCitta i: info) {
			if(i.getStudente().getUsername().equals(target)) {
				si = i;
			}
		}
		
		//Caso Accetta
		if(button.equals("accetta")) {
			si.setStatoConvalida(StatoConvalida.ACCETTATA);
			s.setInfoCitta(si);
		}else //Caso Rifiuta
			if(button.equals("rifiuta")) {
				//Non fa nulla, si limita solo ad eliminare l'informazione ricevuta dal database...
				si.setStatoConvalida(StatoConvalida.RIFIUTATA);
			}
		
		db.setInfoCitta(info);
		db.setStudenti(studenti);
		this.getServletContext().setAttribute("db", db);
		Gson g = new Gson();
		response.getWriter().write(g.toJson(""));
	}
}
