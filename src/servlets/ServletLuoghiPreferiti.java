package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

public class ServletLuoghiPreferiti extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nomeLuogo = request.getParameter("luogo");
		
		InformazioniCitta info = (InformazioniCitta) request.getSession().getAttribute("info");
		
		List<LuogoPreferito> luoghi = info.getListaLuoghiPreferiti();
		
		if(nomeLuogo != null){
			
			//Controlla se non esiste già un altro luogo con questo nome
			boolean trovato = false;
			for(LuogoPreferito lp: luoghi) {
				if(lp.getNomeLuogo().equals(nomeLuogo)) {
					trovato = true;
				}
			}
			
			if(!trovato) {
				LuogoPreferito l = new LuogoPreferito();
				l.setNomeLuogo(nomeLuogo);
				info.aggiungiLuogoPreferito(l);
			}
		}
		
		request.getSession().setAttribute("info", info);
		this.getServletContext().getRequestDispatcher("/info-citta.jsp").forward(request, response);
	}

}
