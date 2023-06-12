<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.*" %>
<%@ page import="java.util.Map" %>

<%
	if(request.getSession().getAttribute("user") == null || request.getSession().getAttribute("ruolo") == null || request.getSession().getAttribute("username") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	
	if(request.getSession().getAttribute("ruolo").equals("studente")) {
		response.sendRedirect("homepage-studente.jsp");
		return;
	}else if(request.getSession().getAttribute("ruolo").equals("utente")){
		response.sendRedirect("homepage-utente.jsp");
		return;
	}

	DatabaseMock db = (DatabaseMock) this.getServletContext().getAttribute("db");
	Map<String, StudenteUniversitario> studenti;
	if(this.getServletContext().getAttribute("ricerca") == null){
		 studenti = db.getStudenti();
	}else{
		studenti = (Map<String, StudenteUniversitario>) this.getServletContext().getAttribute("ricerca");
	}
%>


<!doctype html>
<html lang="en">

<head>
  <title>Gestione Utenti</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="scripts/utils.js"></script>
  <script type="text/javascript" src="scripts/restrizioniAJAX.js"></script>
  <link rel="stylesheet" href="styles/gestione-utenti.css">
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
    <div class="container pt-4 pb-4 box rounded py-5">
        <div class="row my-5">
            <div class="col-md-3 col-sm-12"></div>
            
            <div class="col-md-6 col-sm-12 mt-2">
                <h4 class="text-center">Ecco la lista degli studenti iscritti</h4>
                <h5 class="text-center">Qui potrai gestire i loro profili e le loro restizioni.<h5>
            </div>

            <div class="col-md-3 col-sm-12"></div>
        </div>

        <!-- prima scelta: Universita -->
        <form action="gestioneutenti" method="post" class="py-4 px-4 rounded" id="ricerca">
        	<div class="row  justify-content-start">
            <div class="col-md-1 col-sm-12"></div>
            
            	<div class="col-md-9 col-sm-12 mt-2">
                	<label class="form-check-label" for="cerca">Ricerca uno studente tramite il suo username:</label> </br>
                	<input type="text" name="word" class="form-control" id="" placeholder="Username">
                	<hr>
            	</div>
            	<div class="col-md-1 col-sm-12 mt-2">
                	<br><button type="submit" class="btn btn-primary mb-2 i-btn"><b>Ricerca</b></button>
            	</div>
            	<div class="col-md-1 col-sm-12"></div>
        	</div>
		</form>
        <!-- lista degli utenti -->
        <div class="row justify-content-start">
            <div class="col-md-1 col-sm-12"></div>
            
            <div class="col-md-10 col-sm-12 text-start">
                <div class="link-list-wrapper">
                    <ul class="list-group">
                    <%
                		for (StudenteUniversitario s: studenti.values()){
                			String iniziali = ""+s.getNome().charAt(0)+s.getCognome().charAt(0);
                			String persona = s.getNome()+" "+s.getCognome();
                			String restr = "";
                			String scadenza = "";
                			if(s.getRestrizione() != null){
                				if(s.getRestrizione().gTipoRestrizione() != null){
                    				restr = s.getRestrizione().gTipoRestrizione().toString();
                    			}
                    			if(s.getRestrizione().getScadenza() != null){
                    				scadenza = s.getRestrizione().getScadenza().toString();
                    			}
                			}
                			%>
                				<li class="list-group-item">
		                          <div class="row">    
		                            <div class="col-md-2 col-sm-12">
		                                <div class="avatar rounded-circle size-xl">
		                                    <span class="initials"><%= iniziali %></span>
		                                </div>
		                            </div>
                            
		                            <div class="col-md-3 col-sm-12">
		                                <h2 class="list-group-item-heading"><%= persona %></h2>
		                                <p class="list-group-item-text">
		                                    <strong>Tipo di restrizione:</strong> <%= restr %> <br>
		                                    <strong>Scadenza restrizione:</strong> <%= scadenza %>
		                                </p>
		                            </div>
		                            
		                            
		
		                            <div class="col-md-4 col-sm-12">
		                                <br>
		                                <label class="form-check-label" for="restrizione">Seleziona la restrizione da applicare:</label> </br>
		                                <select class="form-select" id="restrizione_<%=s.getUsername() %>" name="restrizione" aria-label="Default select example">
		                                    <option value="" disabled selected>Seleziona un'opzione...</option>
		                                    <option value="scrittura">Scrittura</option>
		                                    <option value="ban">Ban</option>
		                                </select>
		                                <br>
		                                <div class="form-outline mb-4">
					                        <label class="form-check-label" for="Data">Inserisci la data di scadenza:</label> </br>
					                        <input type="date" id="data_<%=s.getUsername() %>" name="Data" class="form-control" />
					                    </div>
		                            </div>
		
		                            <div class="col-md-3 col-sm-12">
		                                <br><br>
		                                <button type="button" class="btn btn-warning" onClick="modificaRestrizioni('gestioneutenti?b=applica&target=<%= s.getUsername()%>&r='+myGetElementById('restrizione_<%= s.getUsername()%>').value+'&d='+myGetElementById('data_<%= s.getUsername()%>').value)"><b>Applica</b></button>
		                                <button type="button" class="btn btn-danger" onClick="modificaRestrizioni('gestioneutenti?b=rimuovi&target=<%= s.getUsername()%>')"><b>Elimina</b></button>
		                            </div>
		
		                          </div>
		                        </li>
                			<%
                		}
                    %>                      
                    </ul>
                </div>
            </div>

            <div class="col-md-1 col-sm-12"></div>
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
