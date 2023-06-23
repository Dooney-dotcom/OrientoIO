<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>


<html>
<head>
  <title>Recensione Corso</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

    <link rel="stylesheet" href="./styles/recensione-corso.css">

    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

	<script src="./scripts/libs/jquery-1.12.3.min.js"></script>
</head>
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

if(!ruolo.equals("studente") || (ruolo.equals("studente") && ((StudenteUniversitario) session.getAttribute("user")).getRestrizione()!=null )) {
	if(((StudenteUniversitario) session.getAttribute("user")).getRestrizione() != null &&((StudenteUniversitario) session.getAttribute("user")).getRestrizione().getTipoRestrizione().equals(TipoRestrizione.BAN)) {
		// non esiste piu il ban per questa pagina
	}
} else {
		if(ruolo.equals("studente") && (ruolo.equals("studente") && ((StudenteUniversitario) session.getAttribute("user")).getRestrizione()!=null )){ 
			if(((StudenteUniversitario) session.getAttribute("user")).getRestrizione().getTipoRestrizione().equals(TipoRestrizione.SCRITTURA)) {
				response.sendRedirect("./HomeStudente.jsp");
				return;
			}
		}else{

			StudenteUniversitario s = db.getStudenti().get(username);
	
			CorsoDiLaurea c = s.getPianoFormativo().getCorso();
	
			boolean esiste = false;
			for(RecensioneCorso r : db.getRecensioniCorso()) {
        		if(r.getStudente().getUsername().equals(s.getUsername())) { // se gia esiste una recensione scritta dallo studente
        			esiste=true;
        			break;
        		}
        	}
			
			if(!esiste){	
%>
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

    <main class="pt-2 pb-2">

        <div class="container main-container shadow rounded">
            <div class="row text-center mt-4 pt-4">
                <div class="col-sm-12">
                    <h5>Fornisci una recensione sul tuo Corso di Studi: <%=c.getNome() %></h5>
                </div>
            </div>

            <div class="row mt-3 ps-5">
                <div class="col-sm-8">
                    <div class="mb-3">
                      <label for="" class="form-label">Raccontaci di pi&ugrave; sul tuo Corso</label>
                      <textarea class="form-control" name="testoRecensione" id="testoRecensione" rows="3"></textarea>
                    </div>
                </div>
                <div class="col-sm-4">
                	<input type="text" id="studente" hidden="true" value="<%=s%>">
                	<input type="text" id="corso" hidden="true" value="<%=c %>"></div>
            </div>

            <div class="row ps-5">
                <div class="col-sm-12">
                    <label for="" class="form-label">Come valuteresti la qualit&agrave; d'insegnamento del tuo Corso?</label>
                    <div class="ps-2">
                        <span class="field-label-info"></span>
                        <input type="hidden" id="selected_rating" name="selected_rating" value="" required="required">
                        
                        <h2 class="bold rating-header">
                        <span class="selected-rating">0</span><small> / 5</small>
                        </h2>
                        
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
            </div>

            <div class="row mt-3 ps-5">
                <div class="col-sm-8">
                    <div class="mb-3">
                      <label for="sbocchiLavorativi" class="form-label">Dicci di pi&ugrave; sugli Sbocchi Lavorativi del tuo Corso</label>
                      <textarea class="form-control" name="sbocchiLavorativi" id="sbocchiLavorativi" rows="3"></textarea>
                    </div>
                </div>
                <div class="col-sm-4"></div>
            </div>

            <div class="row mt-3 ps-5">
                <div class="col-sm-8">
                    <div class="mb-3">
                      <label for="opportunita" class="form-label">Parlaci delle Opportunit&agrave; che il tuo Corso offre</label>
                      <textarea class="form-control" name="opportunita" id="opportunita" rows="3"></textarea>
                    </div>
                </div>
                <div class="col-sm-4"></div>
            </div>

            <div class="row text-center pt-3 pb-4">
                <div class="col-sm-12">
                    <button type="button" class="btn btn-success" id="invia">Invia la tua Recensione</button>
                    <button type="button" class="btn btn-danger" id="elimina">Elimina la Recensione</button>
                </div>
            </div>
        </div>
    </main>
<%}else {

RecensioneCorso rc = s.getRecensioneCorso();

%>
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

    <main class="pt-2 pb-2">

        <div class="container main-container shadow rounded">
            <div class="row text-center mt-4 pt-4">
                <div class="col-sm-12">
                    <h5>Fornisci una recensione sul tuo Corso di Studi: <%=c.getNome() %></h5>
                </div>
            </div>

            <div class="row mt-3 ps-5">
                <div class="col-sm-8">
                    <div class="mb-3">
                      <label for="" class="form-label">Raccontaci di pi&ugrave; sul tuo Corso</label>
                      <textarea class="form-control" name="testoRecensione" id="testoRecensione" rows="3" readonly><%=rc.getTestoRecensione() %></textarea>
                    </div>
                </div>
                <div class="col-sm-4">
                	<input type="text" id="studente" hidden="true" value="<%=rc.getStudente()%>">
                	<input type="text" id="corso" hidden="true" value="<%=c %>">
                </div>
            </div>

            <div class="row ps-5">
                <div class="col-sm-12">
                    <label for="" class="form-label">Come valuteresti la qualit&agrave; d'insegnamento del tuo Corso?</label>
                    <div class="ps-2">
                        <span class="field-label-info"></span>
                        <input type="hidden" id="selected_rating" name="selected_rating" value="<%=rc.getQualitaInsegnamento() %>" required="required">
                        
                        <h2 class="bold rating-header">
                        <span class="selected-rating"><%=rc.getQualitaInsegnamento() %></span><small> / 5</small>
                        </h2>
                        
                        <button type="button" class="btnrating btn btn-default btn-lg" data-attr="1" id="rating-star-1" selected="" disbaled>
                            <i class="fa fa-star" aria-hidden="true"></i>
                        </button>
                        
                        <button type="button" class="btnrating btn btn-default btn-lg" data-attr="2" id="rating-star-2" disbaled>
                            <i class="fa fa-star" aria-hidden="true"></i>
                        </button>
                        
                        <button type="button" class="btnrating btn btn-default btn-lg" data-attr="3" id="rating-star-3" disbaled>
                            <i class="fa fa-star" aria-hidden="true"></i>
                        </button>
                        
                        <button type="button" class="btnrating btn btn-default btn-lg" data-attr="4" id="rating-star-4" disbaled>
                            <i class="fa fa-star" aria-hidden="true"></i>
                        </button>
                        
                        <button type="button" class="btnrating btn btn-default btn-lg" data-attr="5" id="rating-star-5" disbaled>
                            <i class="fa fa-star" aria-hidden="true"></i>
                        </button>
                    </div>
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
            </div>

            <div class="row mt-3 ps-5">
                <div class="col-sm-8">
                    <div class="mb-3">
                      <label for="sbocchiLavorativi" class="form-label">Dicci di pi&ugrave; sugli Sbocchi Lavorativi del tuo Corso</label>
                      <textarea class="form-control" name="sbocchiLavorativi" id="sbocchiLavorativi" rows="3" readonly><%=rc.getSbocchiLavorativi() %></textarea>
                    </div>
                </div>
                <div class="col-sm-4"></div>
            </div>

            <div class="row mt-3 ps-5">
                <div class="col-sm-8">
                    <div class="mb-3">
                      <label for="opportunita" class="form-label">Parlaci delle Opportunit&agrave; che il tuo Corso offre</label>
                      <textarea class="form-control" name="opportunita" id="opportunita" rows="3" readonly><%=rc.getOpportunitaOfferte() %></textarea>
                    </div>
                </div>
                <div class="col-sm-4"></div>
            </div>

            <div class="row text-center pt-3 pb-4">
                <div class="col-sm-12">
                    <button type="button" class="btn btn-success" id="invia" disabled>Invia la tua Recensione</button>
                    <button class="btn btn-warning" id="modifica">Modifica la Recensione</button>
                    <button type="button" class="btn btn-danger" id="elimina" disabled>Elimina la Recensione</button>
                </div>
            </div>
        </div>
    </main>
<%} }  }%>

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
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js" integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz" crossorigin="anonymous"></script>
  
  <script>
  $("#invia").on({
      click : function() {
          let testo = $("#testoRecensione").val();
          let qualita = $("#selected_rating").val();
          let sbocchi = $("#sbocchiLavorativi").val();
          let opportunita = $("#opportunita").val();
    	  
          let recensioneCorsoRequest = {
        		  message: "invia",
        		  testoRecensione: testo,
        		  qualitaInsegnamento: qualita,
      			  sbocchiLavorativi: sbocchi,
      			  opportunitaOfferte: opportunita,
          };
          
          console.log(recensioneCorsoRequest);
          
          var jsonData = JSON.stringify(recensioneCorsoRequest);
          
          $.ajax({
              url: "recensioneCorso", // Sostituisci con l'URL corretto del server
              method: "POST",
              data: jsonData, // Passa eventuali parametri al server
              dataType: "json", // Imposta il tipo di dati attesi come JSON
              headers: {
                  Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
              },
              contentType: "application/json; charset=utf-8",
              success: function(response) {
            	  if(response.message=="ok"){
            		  alert("Recensione inviata con successo");
            		  
            		  $("#testoRecensione").val(response.testoRecensione);
                      $("#selected_rating").val(response.qualitaInsegnamento);
                      $("#sbocchiLavorativi").val(response.sbocchiLavorativi);
                      $("#opportunita").val(response.opportunitaOfferte);

                      location.reload();
            	  }else{
            		  alert("Errore nella ricezione della risposta");
            	  }
            	  
            	  console.log(response);
              },
              error: function(xhr, status, error) {
                  // Gestisci eventuali errori
                  alert("Errore nell'invio della recensione");
              }
          });
      }
  })


  $("#elimina").on({
      click : function() {
    	  let testo = $("#testoRecensione").val();
          let qualita = $("#selected_rating").val();
          let sbocchi = $("#sbocchiLavorativi").val();
          let opportunita = $("#opportunita").val();
    	  
    	  let recensioneCorsoRequest = {
        		  message: "elimina",
        		  testoRecensione: testo,
        		  qualitaInsegnamento: qualita,
      			  sbocchiLavorativi: sbocchi,
      			  opportunitaOfferte: opportunita,
          };
    	  
    	  console.log(recensioneCorsoRequest);
    	  
          var jsonData = JSON.stringify(recensioneCorsoRequest);
          
          $.ajax({
              url: "recensioneCorso", // Sostituisci con l'URL corretto del server
              method: "POST",
              data: jsonData, // Passa eventuali parametri al server
              dataType: "json", // Imposta il tipo di dati attesi come JSON
              headers: {
                  Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
              },
              contentType: "application/json; charset=utf-8",
              success: function(response) {
            	  
            	  if(response.message=="eliminazione completata"){
            		  alert("Recensione eliminata con successo");
            		  
            		  $("#testoRecensione").val(response.testoRecensione);
                      $("#selected_rating").val(response.qualitaInsegnamento);
                      $("#sbocchiLavorativi").val(response.sbocchiLavorativi);
                      $("#opportunita").val(response.opportunitaOfferte);
            	  }else{
            		  alert("Errore nell'eliminazione");
            	  }
            	  
            	  console.log(response);
              },
              error: function(xhr, status, error) {
                  // Gestisci eventuali errori
                  alert("Errore nell'invio della richiesta di eliminazione della recensione");
              }
          });
      }
  })

  $("#modifica").on({
      click : function() {
          
          $("#invia").prop("disabled", false);
          $("#elimina").prop("disabled", false);
          
          $("#rating-star-1").prop("disabled", false);
          $("#rating-star-2").prop("disabled", false);
          $("#rating-star-3").prop("disabled", false);
          $("#rating-star-4").prop("disabled", false);
          $("#rating-star-5").prop("disabled", false);
          
          $("#testoRecensione").prop("readonly", false);
          $("#sbocchiLavorativi").prop("readonly", false);
          $("#opportunita").prop("readonly", false);
          
          $("#modifica").prop("hidden", true);
          
          alert("modifica attivata");
      }
  })
  </script>
</body>

</html>