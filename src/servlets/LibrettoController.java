package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.EsameSvolto;
import model.Libretto;
import model.StudenteUniversitario;

public class LibrettoController extends HttpServlet{
	
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/*
	 * GET per eliminare un esame dalla lista
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StudenteUniversitario s = (StudenteUniversitario) req.getSession().getAttribute("user");
		String esame = req.getParameter("id");
		if(s == null) {
			resp.sendRedirect("login");
		}
		
		Libretto libretto = s.getLibretto();
		
		libretto.rimuoviEsame(esame);
		
		Gson gson = new Gson();
		resp.getWriter().write(gson.toJson("OK"));
	}
	
	/*
	 * POST per modificare un esame nella lista
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StudenteUniversitario s = (StudenteUniversitario) req.getSession().getAttribute("user");
		String nomeEsame = req.getParameter("id");
		int cfu = Integer.parseInt(req.getParameter("cfu"));
		int voto = Integer.parseInt(req.getParameter("voto"));
		boolean lode = Boolean.parseBoolean(req.getParameter("lode"));
		if(s == null) {
			resp.sendRedirect("login");
		}
		
		Libretto libretto = s.getLibretto();
		
		synchronized (libretto) {
			libretto.modificaEsame(nomeEsame, voto, lode);
		}
		
		Gson gson = new Gson();
		resp.getWriter().write(gson.toJson("OK"));
	}
}
