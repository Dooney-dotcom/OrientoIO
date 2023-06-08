package servlets;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import model.CorsoDiLaurea;
import model.DatabaseMock;
import model.Esame;
import model.PianoFormativo;
import model.Universita;

import util.*;

public class Confronto extends HttpServlet {

    private Gson gson;
    private GsonBuilder gsonBuilder;

    @Override
    public void init() throws ServletException {
        super.init();

        
        this.gsonBuilder = new GsonBuilder();
        gsonBuilder.registerTypeAdapter(LocalDate.class, new LocalDateSerializer());

        gsonBuilder.registerTypeAdapter(LocalDateTime.class, new LocalDateTimeSerializer());

        gsonBuilder.registerTypeAdapter(LocalDate.class, new LocalDateDeserializer());

        gsonBuilder.registerTypeAdapter(LocalDateTime.class, new LocalDateTimeDeserializer());
        
        gsonBuilder.registerTypeAdapter(Duration.class, new DurationSerializer());

        gsonBuilder.registerTypeAdapter(Duration.class, new DurationDeserializer());
        this.gson = gsonBuilder.setPrettyPrinting().create();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String api = req.getParameter("api");
        DatabaseMock db = (DatabaseMock) req.getSession().getServletContext().getAttribute("db");


        //! Request Dispatcher
        /*
         * Facciamo il prefetching mandando una lista di CorsiDiLaurea invece che di nomi
         */
        if(api.equals("university")) {
            Universita u = db.getUniversita().get(req.getParameter("name"));
            List<CorsoResult> result = new ArrayList<>();
            
            for(CorsoDiLaurea corso : u.getCorsiDiLaurea()) {
            	CorsoResult c = new CorsoResult();
            	c.setName(corso.getNome());
            	
            	for(PianoFormativo p : corso.getPianiFormativi()) {
            		PianoFormativoResult pr = new PianoFormativoResult();
            		pr.setName(p.getAnnoImmatricolazione());
            		
            		for(Esame e : p.getEsami()) {
            			EsameResult er = new EsameResult();
            			er.setNome(e.getNome());
            			er.setAnno(e.getAnno());
            			er.setCFU(e.getCFU());
            			er.setLinkEsame(e.getLinkEsame());
            			er.setPeriodo(e.getPeriodo());
            			er.setSSD(e.getSSO());
            			
            			pr.getEsami().add(er);
            		}
            		
            		c.getPiani().add(pr);
            	}
            	
            	result.add(c);
            }
            
            System.out.println(result);
            resp.getWriter().write(gson.toJson(result));
        }
    }
}
