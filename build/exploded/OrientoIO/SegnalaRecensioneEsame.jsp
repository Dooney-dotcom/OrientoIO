<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.time.*" %>
<%@page import="java.time.format.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<% 
if(application.getAttribute("db") == null){
	DatabaseMock db = new DatabaseMock();
	application.setAttribute("db", db);
}

DatabaseMock db = (DatabaseMock) application.getAttribute("db");

if(session.getAttribute("user") == null || session.getAttribute("ruolo") == null || session.getAttribute("username") == null) {
	response.sendRedirect("./login.jsp");
	return;
}

String ruolo = (String) session.getAttribute("ruolo");
String username = (String) session.getAttribute("username");

if(ruolo.equals("amministratore")) {
	response.sendRedirect("./HomeAmministratore.jsp");
	return;
}else{

	Utente utente = (Utente) session.getAttribute("user");
	
	if(request.getParameter("testo")!=null){
		
		String nomeEsame = (String) request.getParameter("nomeEsame");
		String link = (String) request.getParameter("link");
		String usernameStudente = (String) request.getParameter("usernameStudente");
		
		//System.out.println(nomeEsame + " " + link + " " + usernameStudente);
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
        
        // Effettua il parsing della stringa nel LocalDateTime
        LocalDateTime timeStamp = LocalDateTime.parse((String) request.getParameter("timeStamp"), formatter);
        
		String testo = (String) request.getParameter("testo");
		
		SegnalazioneRecensioneEsame s = new SegnalazioneRecensioneEsame();
		
		//troviamo la recensione da segnalare
		for(RecensioneEsame r : db.getRecensioniEsami()){
			if(r.getEsame().getNome().equals(nomeEsame) && r.getEsame().getLinkEsame().equals(link) && r.getStudente().getUsername().equals(usernameStudente)){
				s.setRecensioneSegnalata(r);
				System.out.println(r);
			}
		}
		s.setTestoSegnalazione(testo);
		s.setTimeStamp(timeStamp);
		s.setUtenteSegnalante(utente);
		s.setId((db.getSegnalazioniEsami().size()+1) + "");
		
		//aggiungiamo la segnalazione al db
		db.getSegnalazioniEsami().add(s);
		
		System.out.println(s.toString());
		
		//ridirezione alla pagina di ricerca
		response.sendRedirect("./RicercaCorso.jsp");
		
	}
	else if(request.getParameter("nomeEsame") == null || request.getParameter("link") == null || request.getParameter("usernameStudente") == null){
		response.sendRedirect("./RicercaCorso.jsp");
	}else{
		String nomeEsame = (String) request.getParameter("nomeEsame");
		String link = (String) request.getParameter("link");
		String usernameStudente = (String) request.getParameter("usernameStudente");
	

%>
<html>
<head>
<title>Segnala Recensione Esame</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" rel="stylesheet">

    <link rel="stylesheet" href="./styles/ricercaCorso.css">
    
</head>
<body>
<header>
    <div class="container-fluid shadow">
        <div class="row">
            <div class="col-sm-12 pt-2 pb-2 text-center">
                <img src="./resources/logo-footer.png" class="img-fluid logo" alt="" width="15%">
            </div>
        </div>
    </div>
  </header>
  <main>
    <div class="container-fluid">
        <div class="row">
        	<div class="col-sm-12" >
        		<form action="SegnalaRecensioneEsame.jsp" method="POST">
        		
               		<input type="text" name="nomeEsame" value="<%= nomeEsame%>" hidden>
               		<input type="text" name="link" value="<%= link%>" hidden>
               		<input type="text" name="usernameStudente" value="<%= usernameStudente%>" hidden>
               		
               		<input type="text" name="timeStamp" value="<%= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss"))%>" hidden>
                                      		
        			<label for="testoSegnalazione">Scrivici il perchè questa recensione non va bene!</label>
        		 	<textarea class="form-control" id="testo" name="testo" rows="3"></textarea> </br>
        		 	<button type="submit" class="btn btn-success">Invia Segnalazione</button>
        		</form>
        	</div>
        </div>
    </div>
  </main>
  <footer>
        <div class="container-fluid">
            <div class="row py-2">
                <div class="col-sm-12 text-center">
                    <h6>© 2023 OrientoIO. Tutti i diritti riservati.</h6>
                </div>
            </div>
        </div>
    </footer>
  <!-- Bootstrap JavaScript Libraries -->
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
    integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous">
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
    integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz" crossorigin="anonymous">
  </script>
</body>
</html>
<%}}%>