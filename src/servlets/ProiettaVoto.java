package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.Libretto;
import model.Proiezione;
import model.StudenteUniversitario;

public class ProiettaVoto extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3285293797226308878L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StudenteUniversitario s = (StudenteUniversitario) req.getSession().getAttribute("user");
		int cfu = Integer.parseInt(req.getParameter("cfu"));
		int voto = Integer.parseInt(req.getParameter("voto"));
		boolean lode = Boolean.parseBoolean(req.getParameter("lode"));
		if(s == null) {
			resp.sendRedirect("login");
		}
		
		Libretto libretto = s.getLibretto();
		
		Proiezione proiezione = libretto.proiettaVoto(voto, cfu, lode);
		
		Gson gson = new Gson();
		
		resp.getWriter().write(gson.toJson(proiezione));
	}
}
