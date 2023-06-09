<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.*" %>

<%
	StudenteUniversitario stud = (StudenteUniversitario) this.getServletContext().getAttribute("stud");
%>

<!doctype html>
<html lang="en">

<head>
  <title>Studente</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="styles/homepage-studente.css">
</head>
<body>
  <header>
    <div class="container-fluid shadow">
        <div class="row">
            <div class="col-sm-12 pt-2 pb-2 text-center">
                <img src="images/logo-footer.png" class="img-fluid logo" alt="" width="15%">
            </div>
        </div>
    </div>
  </header>
  <main>
    <div class="container-fluid">  
        <div class="row pt-3">
            <div class="col-sm-12 text-center">
                <h3>Ciao <%= stud.getUsername().toUpperCase()%>, bentornato!</h3>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 text-center">
                <h4>Esplora le funzionalit� della nostra piattaforma</h4>
            </div>
        </div>
        <div class="row main-row pt-4 ps-4 pe-4">
            <div class="col-sm-12 col-md-3">
                <div class="card shadow" style="width: 18rem;">
                    <div class="img-container rounded-top">
                        <img class="card-img-top university-img rounded-top" src="images/university.jpg" alt="Card image cap">
                    </div>
                    <div class="card-body rounded-bottom">
                      <h5 class="card-title">Ricerca</h5>
                      <p class="card-text">Ricerca tra tutti i corsi e universit&agrave; del nostro database ci� che pi� fa per te</p>
                      <a href="#" class="btn go-btn">Ricerca Corsi</a>
                      <a href="#" class="btn go-btn mt-2">Ricerca Universit&agrave;</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-3">
                <div class="card shadow" style="width: 18rem;">
                    <div class="img-container">
                        <img class="card-img-top rounded-top" src="images/class.jpg" width="400px" alt="Card image cap">
                    </div>
                    <div class="card-body rounded-bottom">
                      <h5 class="card-title">Lista Preferiti</h5>
                      <p class="card-text">Esplora la lista dei tuoi corsi preferiti e ottieni pi&ugrave; informazioni</p>
                      <a href="#" class="btn go-btn">Corsi Preferiti</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-3">
                <div class="card rounded shadow" style="width: 18rem;">
                    <div class="img-container">
                        <img class="card-img-top rounded-top" src="images/exam.jpg" alt="Card image cap">
                    </div>
                    <div class="card-body rounded-bottom">
                      <h5 class="card-title">Piani Formativi</h5>
                      <p class="card-text">Confronta varie liste di esami dei corsi e scopri le loro differenze</p>
                      <a href="#" class="btn go-btn">Confronta</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-3">
                <div class="card shadow" style="width: 18rem;">
                    <div class="img-container">
                        <img class="card-img-top rounded-top" src="images/city.jpg" alt="Card image cap">
                    </div>
                    <div class="card-body rounded-bottom">
                      <h5 class="card-title">Mappa Citt�</h5>
                      <p class="card-text">Ottieni pi� informazioni sulle citt&agrave; universitarie sparse per l'Italia!</p>
                      <a href="#" class="btn go-btn">Vai alla mappa</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row main-row pt-4 ps-4 pe-4">
            <div class="col-sm-12 col-md-3">
                <div class="card shadow" style="width: 18rem;">
                    <div class="img-container rounded-top">
                        <img class="card-img-top university-img rounded-top" src="images/university.jpg" alt="Card image cap">
                    </div>
                    <div class="card-body rounded-bottom">
                      <h5 class="card-title">Ricerca</h5>
                      <p class="card-text">Ricerca tra tutti i corsi e universit&agrave; del nostro database ci� che pi� fa per te</p>
                      <a href="#" class="btn go-btn">Ricerca Corsi</a>
                      <a href="#" class="btn go-btn mt-2">Ricerca Universit&agrave;</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-3">
                <div class="card shadow" style="width: 18rem;">
                    <div class="img-container">
                        <img class="card-img-top rounded-top" src="images/class.jpg" width="400px" alt="Card image cap">
                    </div>
                    <div class="card-body rounded-bottom">
                      <h5 class="card-title">Lista Preferiti</h5>
                      <p class="card-text">Esplora la lista dei tuoi corsi preferiti e ottieni pi&ugrave; informazioni</p>
                      <a href="#" class="btn go-btn">Corsi Preferiti</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-3">
                <div class="card rounded shadow" style="width: 18rem;">
                    <div class="img-container">
                        <img class="card-img-top rounded-top" src="images/exam.jpg" alt="Card image cap">
                    </div>
                    <div class="card-body rounded-bottom">
                      <h5 class="card-title">Piani Formativi</h5>
                      <p class="card-text">Confronta varie liste di esami dei corsi e scopri le loro differenze</p>
                      <a href="#" class="btn go-btn">Confronta</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-3">
                <div class="card shadow" style="width: 18rem;">
                    <div class="img-container">
                        <img class="card-img-top rounded-top" src="images/city.jpg" alt="Card image cap">
                    </div>
                    <div class="card-body rounded-bottom">
                      <h5 class="card-title">Mappa Citt�</h5>
                      <p class="card-text">Ottieni pi� informazioni sulle citt&agrave; universitarie sparse per l'Italia!</p>
                      <a href="#" class="btn go-btn">Vai alla mappa</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
  </main>
   <footer>
        <div class="container-fluid">
            <div class="row py-2">
                <div class="col-sm-12 text-center">
                    <h6>� 2023 OrientoIO. Tutti i diritti riservati.</h6>
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