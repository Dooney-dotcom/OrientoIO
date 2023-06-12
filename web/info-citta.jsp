<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
	if(request.getSession().getAttribute("user") == null || request.getSession().getAttribute("ruolo") == null || request.getSession().getAttribute("username") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	
	if(request.getSession().getAttribute("ruolo").equals("utente")) {
		response.sendRedirect("homepage-utente.jsp");
		return;
	}else if(request.getSession().getAttribute("ruolo").equals("amministratore")){
		response.sendRedirect("HomeAmministratore.jsp");
		return;
	}
	
	StudenteUniversitario stud = (StudenteUniversitario) request.getSession().getAttribute("user");
	String ruolo = (String) request.getSession().getAttribute("ruolo");
	
	if(ruolo.equals("studente") && (stud.getRestrizione() != null && stud.getRestrizione().getTipoRestrizione().equals(TipoRestrizione.BAN))){
		response.sendRedirect("login.jsp");
		return;
	}
	
	if(ruolo.equals("studente") && (stud.getRestrizione() != null && stud.getRestrizione().getTipoRestrizione().equals(TipoRestrizione.SCRITTURA))){
		response.sendRedirect("ban.html");
		return;
	}
	
	InformazioniCitta info;
	if(request.getSession().getAttribute("info") != null){
		info = (InformazioniCitta) request.getSession().getAttribute("info");
	}else{
		info = stud.getInfoCitta();
		request.getSession().setAttribute("info", info);
	}
%>

<!doctype html>
<html lang="en">

<head>
  <title>InfoCitt&agrave;</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

    <link rel="stylesheet" href="styles/info-citta.css">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    
    <script src="./script/jquery-1.12.3.min.js"></script>
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
    <div class="container pt-4 pb-4 box rounded py-5">
    <div class="row my-5">
            <div class="col-md-3 col-sm-12"></div>
            <div class="col-md-6 col-sm-12 mt-2">
                <h4 class="text-center">Inserisci le informazioni per la tua citt&agrave; universitaria</h4>
            </div>
            <div class="col-md-3 col-sm-12"></div>
        </div>
    <!-- luoghi preferiti -->
        <form action="luogopreferito" method="post">
        	<div class="row justify-content-start">
	          <div class="col-md-1 col-sm-12"></div>
	          <div class="col-sm-9 text-start">
	             <div class="form-outline mb-4">
	                 <label class="form-check-label" for="luoghi">Inserisci un luogo di interesse/preferito:</label> </br>
	                 <input class="form-control" id="luoghi" name="luogo">
	             </div>
	          </div>
	          <div class="col-md-2 col-sm-12">
                <br><button type="reset" class="btn btn-primary mb-2 i-btn"><b>reset</b></button>
                <button type="submit" class="btn btn-primary mb-2 i-btn"><b>+</b></button>
            </div>
        	</div>
        	<div class="row justify-content-start">
            <div class="col-md-1 col-sm-12"></div>
            <div class="col-sm-10 text-start">
                <div class="form-outline mb-4">
                    <label class="form-check-label" for="luoghi">Ecco i luoghi di interesse/preferiti inseriti fin'ora:</label> </br>
                    <ul class="list-unstyled">
                    <%
                    	if(info.getListaLuoghiPreferiti() != null){
                    		for(LuogoPreferito l: info.getListaLuoghiPreferiti()){
                    			if(!l.getNomeLuogo().isBlank() || !l.getNomeLuogo().isEmpty())
                    			%>
                    				<li><strong><%=l.getNomeLuogo().toUpperCase()%></strong></li>
                    			<%
                    		}
                    	}
                    %>
                    </ul>
                </div>
            </div>
            <div class="col-md-1 col-sm-12"></div>
        </div>
        </form>
    <form action="infocitta" method="post">
        <div class="row  justify-content-start">
            <div class="col-md-1 col-sm-12"></div>
            
            <!-- tipologia abitazione -->
            <div class="col-md-5 col-sm-12 mt-2">
            	<div class="form-outline mb-4">
		            <label class="form-check-label" for="abitazione">Seleziona la tua tipologia di abitazione:</label> </br>
		                   <select class="form-select" aria-label="Default select example" id="abitazione" name="abitazione">
		                       <option value="" disabled selected>Seleziona un'opzione...</option>
		                       <option value="Singola">Singola</option>
		                       <option value="Doppia">Doppia</option>
		                       <option value="Tripla">Tripla</option>
		                       <option value="Monolocale">Monolocale</option>
		                       <option value="Bilocale">Bilocale</option>
                    	  </select>
                </div>
            </div>

             <!-- costo affitto -->
            <div class="col-md-5 col-sm-12 mt-2 text-end justify-content-end">
                <div class="form-outline mb-4">
                    <label class="form-check-label" for="affitto">Inserisci il costo del tuo affitto (&euro;):</label> </br>
                    	<input type="text" class="form-control" name="affitto" id="affitto" aria-describedby="helpId" placeholder="es. 500">
                </div>
            </div>

            <div class="col-md-1 col-sm-12"></div>
        </div>


        <div class="row justify-content-start">
            <div class="col-md-1 col-sm-12"></div>
            
            <!-- valutazione mezzi -->
            <div class="col-md-5 col-sm-12 justify-content-start">
                <label class="form-check-label" for="mezzi">Seleziona il livello dei mezzi:</label> </br>
                
                <span class="field-label-info"></span>

                <input type="hidden" id="selected_rating" name="selected_rating" value="" required="required">
                
                <h2 class="bold rating-header">

                <span class="selected-rating">0</span> <small> / 5</small></h2>

                <button type="button" class="btnrating btn btn-default btn-lg" data-attr="1" id="rating-star-1">
                    <i class="fa fa-star" aria-hidden="true"></i>
                </button>

                <button type="button" class="btnrating btn btn-default btn-lg" data-attr="2" id="rating-star-2">
                    <i class="fa fa-star" aria-hidden="true"></i>
                </button>

                <button type="button" class="btnrating btn btn-default btn-lg" data-attr="3" id="rating-star-3">
                    <i class="fa fa-star" aria-hidden="true"></i>
                </button>

                <button type="button" class="btnrating btn btn-default btn-lg" data-attr="4" id="rating-star-4">
                    <i class="fa fa-star" aria-hidden="true"></i>
                </button>

                <button type="button" class="btnrating btn btn-default btn-lg" data-attr="5" id="rating-star-5">
                    <i class="fa fa-star" aria-hidden="true"></i>
                </button>
        </div>

        <script>
            jQuery(document).ready(function($){

                $(".btnrating").on('click',(function(e) {
                
                var previous_value = $("#selected_rating").val();
                
                var selected_value = $(this).attr("data-attr");
                $("#selected_rating").val(selected_value);
                
                $(".selected-rating").empty();
                $(".selected-rating").html(selected_value);
                
                for (i = 1; i <= selected_value; ++i) {
                $("#rating-star-"+i).toggleClass('star-selected');
                $("#rating-star-"+i).toggleClass('star-default');
                }
                
                for (ix = 1; ix <= previous_value; ++ix) {
                $("#rating-star-"+ix).toggleClass('star-selected');
                $("#rating-star-"+ix).toggleClass('star-default');
                }
                
                }));
                
            });
        </script>

            <!-- livello culturale -->
            <div class="col-md-5 col-sm-12 text-end justify-content-end">
                    <label class="form-check-label" for="Corso2">Seleziona il livello culturale:</label> </br>
                    
                    <span class="field-label-info"></span>

                    <input type="hidden" id="selected_rating2" name="selected_rating2" value="" required="required">
                    
                    <h2 class="bold rating-header">

                    <span class="selected-rating2">0</span> <small> / 5</small> </h2>

                    <button type="button" class="btn btn-default btn-lg btnrating2" data-attr="1" id="rating-star-2-1">
                        <i class="fa fa-star" aria-hidden="true"></i>
                    </button>

                    <button type="button" class="btn btn-default btn-lg btnrating2" data-attr="2" id="rating-star-2-2">
                        <i class="fa fa-star" aria-hidden="true"></i>
                    </button>

                    <button type="button" class="btn btn-default btn-lg btnrating2" data-attr="3" id="rating-star-2-3">
                        <i class="fa fa-star" aria-hidden="true"></i>
                    </button>

                    <button type="button" class="btn btn-default btn-lg btnrating2" data-attr="4" id="rating-star-2-4">
                        <i class="fa fa-star" aria-hidden="true"></i>
                    </button>

                    <button type="button" class="btn btn-default btn-lg btnrating2" data-attr="5" id="rating-star-2-5">
                        <i class="fa fa-star" aria-hidden="true"></i>
                    </button>
            </div>

            <script>
                jQuery(document).ready(function($){

                    $(".btnrating2").on('click',(function(e) {
                    
                    var previous_value2 = $("#selected_rating2").val();
                    
                    var selected_value2 = $(this).attr("data-attr");
                    $("#selected_rating2").val(selected_value2);
                    
                    $(".selected-rating2").empty();
                    $(".selected-rating2").html(selected_value2);
                    
                    for (i = 1; i <= selected_value2; ++i) {
                    $("#rating-star-2-"+i).toggleClass('star-selected');
                    $("#rating-star-2-"+i).toggleClass('star-default');
                    }
                    
                    for (ix = 1; ix <= previous_value2; ++ix) {
                    $("#rating-star-2-"+ix).toggleClass('star-selected');
                    $("#rating-star-2-"+ix).toggleClass('star-default');
                    }
                    
                    }));
                    
                });
            </script>

            <div class="col-md-1 col-sm-12"></div>
        </div>

        <!-- recensione -->
        <div class="row justify-content-start">
            <div class="col-md-1 col-sm-12"></div>
            
            <div class="col-sm-10 text-start">
                <div class="form-outline mb-4">
                    <label class="form-check-label" for="recensione">Inserisci la tua recensione:</label> </br>
                    <textarea class="form-control" id="recensione" name="recensione" rows="3"></textarea>
                </div>
            </div>

            <div class="col-md-1 col-sm-12"></div>
        </div>

        <div class="row justify-content-start">
            <div class="col-md-5 col-sm-12"></div>
            
            <div class="col-sm-2 text-start">
                <div class="form-outline mb-4">
                    <button type="submit" name="invia" class="btn btn-success">Invia la tua Recensione</button>  
                </div>
            </div>
       

            <div class="col-md-5 col-sm-12"></div>
        </div>   
        </form>  
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