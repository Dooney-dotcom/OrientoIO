<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.*" %>

<%
	if(request.getSession().getAttribute("user") == null || request.getSession().getAttribute("ruolo") == null || request.getSession().getAttribute("username") == null) {
		response.sendRedirect("login.jsp");
	}

	if(request.getSession().getAttribute("ruolo").equals("studente")) {
		response.sendRedirect("homepage-studente.jsp");
	}else if(request.getSession().getAttribute("ruolo").equals("utente")){
		response.sendRedirect("homepage-utente.jsp");
	}
	
	Account a = (Account) request.getSession().getAttribute("user");

%>

<!doctype html>
<html lang="en">

<head>
  <title>Amministratore</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="styles/homepage-utente.css">
</head>
<body>
  <header>
    <div class="container-fluid shadow">
        <div class="row">
            <div class="col-sm-12 pt-2 pb-2 text-center">
                <img src="resources/logo-footer.png" class="img-fluid logo" alt="" width="15%">
            </div>
        </div>
    </div>
  </header>
  <main>
    <div class="container-fluid">  
        <div class="row pt-3">
            <div class="col-sm-12 text-center">
                <h3>Ciao <%= a.getUsername().toUpperCase() %>, bentornato!</h3>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-center">
                <h4>Esplora le funzionalit&agrave; della nostra piattaforma</h4>
            </div>
        </div>
        <div class="row main-row pt-4 ps-4 pe-4">
        <div class="col-sm-12 col-md-3"></div>
            <div class="col-sm-12 col-md-3">
                <div class="card shadow" style="width: 18rem;">
                    <div class="img-container rounded-top">
                        <img class="card-img-top university-img rounded-top" src="resources/university.jpg" alt="Card image cap">
                    </div>
                    <div class="card-body rounded-bottom">
                      <h5 class="card-title">Gestione Utenti</h5>
                      <p class="card-text">Verifica e modifica lo stato degli utenti!</p>
                      <a href="<%= request.getContextPath() %>/gestione-utenti.jsp" class="btn go-btn">Vai a Gestione Utenti</a>
                      <a href="<%= request.getContextPath() %>/segnalazioni.jsp" class="btn go-btn mt-2">Visualizza le Segnalazioni</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-3">
                <div class="card shadow" style="width: 18rem;">
                    <div class="img-container">
                        <img class="card-img-top rounded-top" src="resources/class.jpg" width="400px" alt="Card image cap">
                    </div>
                    <div class="card-body rounded-bottom">
                      <h5 class="card-title">Convalida Informazioni</h5>
                      <p class="card-text">Visualizza le informazioni inviate dagli studenti!</p>
                      <a href="<%= request.getContextPath() %>/convalida-informazioni.jsp" class="btn go-btn">Convalida Informazioni</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-3"></div>
        </div>
    </div>
  </main>
  <footer>
        <div class="container-fluid">
            <div class="row py-2">
                <div class="col-sm-12 text-center">
                    <h6><i class="bi bi-c-circle"></i> 2023 OrientoIO. Tutti i diritti riservati.</h6>
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