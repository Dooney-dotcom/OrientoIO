package servlets;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

public class ServletInfoCitta extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tipo = request.getParameter("abitazione");
		String costo = request.getParameter("affitto");
		String mezzi = request.getParameter("mezzi");
		String cultura = request.getParameter("cultura");
		String recensione = request.getParameter("recensione");
		
		InformazioniCitta info = (InformazioniCitta) request.getSession().getAttribute("info");
		
		if(!tipo.equals("") && tipo != null && !costo.equals("") && costo != null
				&& !mezzi.equals("") && mezzi != null && !cultura.equals("") &&
					cultura != null && !recensione.equals("") && recensione != null) {
			
			info.setStudente((StudenteUniversitario) request.getSession().getAttribute("user"));
			info.setTipoAbitazione(tipo);
			info.setAffitto(Float.parseFloat(costo));
			info.setValutazioneMezzi(Integer.parseInt(mezzi));
			info.setLivelloCulturale(Integer.parseInt(cultura));
			info.setRecensioneCitta(recensione);
			
			request.getSession().setAttribute("info", info);
			
			//Invia per la convalida
			DatabaseMock db = (DatabaseMock) this.getServletContext().getAttribute("db");
			db.getInfoCitta().add(info);
			this.getServletContext().setAttribute("db", db);
		}

		this.getServletContext().getRequestDispatcher("/homepage-studente.jsp").forward(request, response);
	}
}
