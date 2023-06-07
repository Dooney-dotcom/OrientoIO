package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.Esame;
import model.EsameSvolto;
import model.Libretto;
import model.StudenteUniversitario;

public class RegistraEsame extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StudenteUniversitario s = (StudenteUniversitario) req.getSession().getAttribute("user");
		int i = Integer.parseInt(req.getParameter("id"));
		if(s == null) {
			resp.sendRedirect("login");
		}
		
		List<Esame> esami = s.getPianoFormativo().getEsami();
		
		Gson gson = new Gson();
		
		resp.getWriter().write(gson.toJson(esami.get(i).getCFU()));
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StudenteUniversitario s = (StudenteUniversitario) req.getSession().getAttribute("user");
		int i = Integer.parseInt(req.getParameter("esame"));
		int voto = Integer.parseInt(req.getParameter("voto"));
		boolean lode = Boolean.parseBoolean(req.getParameter("lode"));
		if(s == null) {
			resp.sendRedirect("login");
		}
		
		Esame esame = s.getPianoFormativo().getEsami().get(i);
		EsameSvolto esameSvolto = new EsameSvolto();
		esameSvolto.setVoto(voto);
		esameSvolto.setLode(lode);
		esameSvolto.setEsame(esame);
		
		boolean found = false;
		
		Libretto libretto = s.getLibretto();
		
		for(EsameSvolto x : libretto.getEsamiSvolti()) {
			if(x.getEsame().getNome().equals(esame.getNome())) {
				found = true;
				break;
			}
		}
		
		Gson gson = new Gson();
		
		if(found) {
			resp.getWriter().write(gson.toJson("Esame già registrato!"));
		} else {
			libretto.registraVoto(esameSvolto);
			resp.getWriter().write(gson.toJson("Esame registrato correttamente!"));
		}
	}
}
