package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;

public class ListaPreferiti extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1671695252989587253L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String api = req.getParameter("api");
		
		/*
		 * Request Dispatcher
		 */
		if(api.equals("search")) {
			String name = req.getParameter("name");

			DatabaseMock db = (DatabaseMock) req.getSession().getServletContext().getAttribute("db");
			List<CorsoDiLaurea> corsi = db.getCorsi();
			List<String> result = new ArrayList<>();
 			for(CorsoDiLaurea c : corsi) {
				if(c.getNome().toLowerCase().contains(name.toLowerCase())) {
					result.add(c.getUniversita().getNome() + "____" + c.getNome() + "____" + c.getTipo().toString());
				}
			}
 			
 			Gson gson = new Gson();
 			resp.setCharacterEncoding("UTF-8");
 			resp.getWriter().write(gson.toJson(result));
 			
 			
		} else if(api.equals("add")) {
			String[] param = req.getParameter("name").split("____");
			
			DatabaseMock db = (DatabaseMock) req.getSession().getServletContext().getAttribute("db");
			List<CorsoDiLaurea> corsi = db.getCorsi();
			CorsoDiLaurea result = null;
 			for(CorsoDiLaurea c : corsi) {
				if(c.getNome().toLowerCase().equals(param[1].toLowerCase()) && 
						c.getUniversita().getNome().toLowerCase().equals(param[0].toLowerCase())) {
					result = c;
					break;
				}
			}
 			
 			String response = "";
 			
 			if(result != null) {
 				Utente user = (Utente) req.getSession().getAttribute("user");
 				
 				List<CorsoDiLaurea> preferiti = user.getListaPreferiti().getCorsiDiLaurea();
 				
 				boolean found = false;
 				for(CorsoDiLaurea c : preferiti) {
 					if(c.getNome().equals(result.getNome()) && c.getUniversita().getNome().equals(result.getUniversita().getNome())) {
 						found = true;
 						break;
 					}
 				}
 				
 				if(found) {
 					response = "Corso già inserito nella lista!";
 				} else {
 					response = "Corso inserito correttamente nella lista!";
 					preferiti.add(result);
 				}
 			} else {
 				response = "Errore. Corso non trovato nel sistema";
 			}
 			
 			Gson gson = new Gson();
 			resp.setCharacterEncoding("UTF-8");
 			resp.getWriter().write(gson.toJson(response));
		} else if(api.equals("remove")) {
			String[] param = req.getParameter("name").split("____");
			
			Utente user = (Utente) req.getSession().getAttribute("user");
				
			List<CorsoDiLaurea> preferiti = user.getListaPreferiti().getCorsiDiLaurea();
				
			int index = -1;
			for(int i = 0; i < preferiti.size(); i++) {
				if(preferiti.get(i).getNome().equals(param[1]) &&
						preferiti.get(i).getUniversita().getNome().equals(param[0])) {
					index = i;
					break;
				}
			}
			
			preferiti.remove(index);
			
			Gson gson = new Gson();
 			resp.setCharacterEncoding("UTF-8");
 			resp.getWriter().write(gson.toJson("Corso rimosso dalla lista."));
		}
	}
}
