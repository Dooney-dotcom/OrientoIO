package servlets;

import java.io.IOException;
import java.time.Duration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;
import util.RecensioneEsameResult;

public class RecensioneEsameServlet extends HttpServlet{

    Gson gson;

    @Override
    public void init() throws ServletException {
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StudenteUniversitario s = (StudenteUniversitario) request.getSession().getAttribute("user");
        if(s == null) {
            response.sendRedirect("login.jsp");
        }

        String exam = request.getParameter("exam");
        RecensioneEsame result = null;

        for(RecensioneEsame r : s.getRecensioniEsami()) {
            if(r != null && r.getEsame() != null && r.getEsame().getNome().equals(exam)) {
                result = r;
                break;
            }
        }

        if(result != null) {
            RecensioneEsameResult review = new RecensioneEsameResult();
            review.setRating(result.getValutazioneProfessore());
            review.setVoto(result.getVoto() == 30 && result.getLode() ? "30L" : result.getVoto().toString());
            review.setReview(result.getTestoRecensione());
            int hours = (int) result.getTempoDiStudio().toHoursPart();
            review.setHours(hours);
            review.setWeeks((int) result.getTempoDiStudio().toDaysPart()/7);

            response.getWriter().write(gson.toJson(review));
        } else {
            RecensioneEsameResult review = new RecensioneEsameResult();
            review.setRating(0);
            review.setVoto("");
            review.setReview("");
            review.setHours(0);
            review.setWeeks(0);

            response.getWriter().write(gson.toJson(review));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StudenteUniversitario s = (StudenteUniversitario) request.getSession().getAttribute("user");
        if(s == null) {
            response.sendRedirect("login.jsp");
        }

        String exam = request.getParameter("exam");
        RecensioneEsame review = null;

        for(RecensioneEsame r : s.getRecensioniEsami()) {
            if(r != null && r.getEsame() != null && r.getEsame().getNome().equals(exam)) {
                review = r;
                break;
            }
        }

        if(review == null) {
            review = new RecensioneEsame();
            review.setStudente(s);
            s.getRecensioniEsami().add(review);
            //! Bisogna settare l'esame. Lo cerco nel piano formativo
            for (Esame e : s.getPianoFormativo().getEsami()) {
                if(e.getNome().equals(exam)) {
                    review.setEsame(e);
                    break;
                }
            }
        }

        String voto = request.getParameter("voto");
        String recensione = request.getParameter("review");
        String rating = request.getParameter("selected_rating");
        System.out.println("Rating: " + rating);
        Integer weeks = Integer.parseInt(request.getParameter("weeks"));
        Integer hours = Integer.parseInt(request.getParameter("hours"));
        Duration duration = Duration.ofDays(weeks*7);
        duration = duration.plusHours(hours);
        review.setVoto(voto.equals("30L") ? 30 : Integer.parseInt(voto));
        review.setTestoRecensione(recensione);
        review.setValutazioneProfessore(Integer.parseInt(rating));
        review.setLode(voto.equals("30L"));
        review.setTempoDiStudio(duration);

        response.sendRedirect("recensione-esame.jsp");
    }
}
