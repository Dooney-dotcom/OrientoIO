<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.*" %>
<%@ page import="java.util.Map" %>

<%
// 1) Caricamento del Database se non è stato caricato
if(application.getAttribute("db") == null) {
	DatabaseMock db = new DatabaseMock();
	application.setAttribute("db", db);
}

// 2) Prendere il Database
DatabaseMock db = (DatabaseMock)application.getAttribute("db");

// 3) Se si è fatto il login si torna alla pagina di login che reindirizzerà alla pagina corretta
// Attributo user contiene utente oppure studente universitario in base a "ruolo"
// Attributo username contiene l'username
// Questi tre attributi vanno impostati in fase di login
if(session.getAttribute("user") != null || session.getAttribute("username") != null || session.getAttribute("ruolo") != null) {
    response.sendRedirect("login.jsp");
    return;
}

String errore = "";
//Controllo errore
if(request.getSession().getAttribute("errore") != null){
	errore = (String) request.getSession().getAttribute("errore"); 
}

// Prendo le citta dal Database
Map<String, CittaUniversitaria> citta = db.getCitta();
%>

<!doctype html>
<html lang="en">

<head>
  <title>Registrazione</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

    <link rel="stylesheet" href="styles/registrazione.css">

    <!-- JQuery -->
    <script src="./scripts/libs/jquery-1.12.3.min.js"></script>

    <!-- Bootstrap JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
    integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous">
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
    integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz" crossorigin="anonymous">
    </script>

    <!-- Script -->
    <script src="./scripts/registrazione.js" defer></script>
    
    <script>
    	function hideStudent(){
    		var uni = document.getElementById("Universita");
    		var city = document.getElementById("Citta");
    		var c = document.getElementById("Corso");
    		var p = document.getElementById("Piano");
    		
    		console.log(document.getElementById("Studente").checked);
    		
    		if(!document.getElementById("Studente").checked){
    			uni.hidden=true;
        		city.hidden=true;
        		c.hidden=true;
        		p.hidden=true;
    		}else{
    			uni.hidden=false;
        		city.hidden=false;
        		c.hidden=false;
        		p.hidden=false;
    		}
    	}
    	
    	function formValidation(){
    		var nome = document.getElementById("Nome");
    		var snome = document.getElementById("Cognome");
    		var date = document.getElementById("Data");
    		var us = document.getElementById("Username");
    		var pass = document.getElementById("Password");
    		
    		if(nome.value == "" || snome.value == "" || date.value == "" || us.value == "" || pass.value == ""){
    			alert("Devi completare tutti i campi.");
    		}
    		
    		if(document.getElementById("Studente").checked){
    			var uni = document.getElementById("uni");
        		var city = document.getElementById("cit");
        		var c = document.getElementById("co");
        		var p = document.getElementById("pi");
        		
        		if(uni.value == "" || city.value == "" || c.value == "" || p.value == ""){
        			alert("Devi completare tutti i campi se vuoi registrarti come StudenteUniversitario.");
        		}
    		}
    	}
    </script>
</head>

<body>
  <header>
    <div class="container-fluid">
        <div class="row pt-0 pb-0 shadow">
            <div class="col-md-4 col-sm-12 logo-container pt-0 pb-0 mt-0 mb-0">
                <img class="header-logo" src="resources/logo.png" alt="logo" width="30%">
            </div>
            <div class="col-md-8 col-sm-12 pt-0 mt-0 pb-0 mb-0 pe-5 text-end">
                <span class="home-title h1">OrientoIO</span>
            </div>
        </div>
    </div>
  </header>
<main>
    <div class="container pt-4 pb-4 ">
        <form action="registrazione" method="post" class="rounded box shadow pt-3 ps-4 pe-4" onSubmit='formValidation()' id="registration">
            <div class="row">
                <div class="col-md-3 col-sm-12"></div>
                
                <div class="col-md-6 col-sm-12 mt-2">
                    <h2 class="text-center">Registrati su OrientoIO!</h2>
                </div>

                <div class="col-md-3 col-sm-12"></div>
            </div>
            
            <div class="row">
            	<div class="col-sm-12">
            		<p class="text-center pt-2" style="color:red;"><i><%=errore%></i></p>
            	</div>
            </div>

            <div class="row">
                <div class="col-md-3 col-sm-12"></div>

                <div class="col-md-3 col-sm-12 mt-2">
                    <!-- input nome -->
                    <div class="form-outline mb-4">
                        <label class="form-check-label" for="Nome">Inserisci il nome:</label> </br>
                        <input type="text" id="Nome" name="Nome" class="form-control" placeholder="Nome"/>
                    </div>
                </div>

                <div class="col-md-3 col-sm-12 mt-2">
                    <!-- input cognome -->
                    <div class="form-outline mb-4">
                        <label class="form-check-label" for="Cognome">Inserisci il cognome:</label> </br>
                        <input type="text" id="Cognome" name="Cognome" class="form-control" placeholder="Cognome" />
                    </div>
                </div>

                <div class="col-md-3 col-sm-12"></div>
            </div>

            <div class="row">
                <div class="col-md-3 col-sm-12"></div>

                <div class="col-md-6 col-sm-12 mt-2">
                    <!-- input data -->
                    <div class="form-outline mb-4">
                        <label class="form-check-label" for="Data"">Inserisci la tua data di nascita:</label> </br>
                        <input type="date" id="Data" name="Data" class="form-control" />
                    </div>
                </div>

                <div class="col-md-3 col-sm-12"></div>
            </div>

            <div class="row">
                <div class="col-md-3 col-sm-12"></div>

                <div class="col-md-3 col-sm-12 mt-2">
                    <!-- input username -->
                    <div class="form-outline mb-4">
                        <label class="form-check-label" for="Username">Inserisci il tuo username:</label> </br>
                        <input type="text" id="Username" name="Username" class="form-control" placeholder="Username" size="5"/>
                    </div>
                </div>

                <div class="col-md-3 col-sm-12 mt-2">
                    <!-- input Password-->
                    <div class="form-outline mb-4">
                        <label class="form-check-label" for="Password">Crea una password:</label> </br>
                        <input type="password" id="Password" name="Password" class="form-control" placeholder="Password"/>
                    </div>
                </div>

                <div class="col-md-3 col-sm-12"></div>
            </div>

            <div class="row">
                <div class="col-md-3 col-sm-12"></div>

                <div class="col-md-6 col-sm-12 mt-2">
                    <!-- input StudenteUni -->
                    <div class="form-outline mb-4 text-center">
                        <label class="form-check-label" for="Studente">Sei uno Studente Universitario?</label>
                        <input class="form-check-input" type="checkbox" value="" id="Studente" onClick='hideStudent()' checked/>
                    </div>
                </div>

                <div class="col-md-3 col-sm-12"></div>
            </div>

            <!-- campi opzionali -->
            <div class="row">
                <div class="col-md-3 col-sm-12"></div>

                <div class="col-md-6 col-sm-12 mt-2">
                    <!-- input Universita -->
                    <div class="form-outline mb-4" id="Citta">
                        <label class="form-check-label" for="city">Seleziona la tua Citta Universitaria:</label> </br>
                        <select class="form-select" id="city" name="city" aria-label="Default select example">
                            <option value="" disabled selected>Seleziona un'opzione...</option>
                            <% for(String c : citta.keySet()) { %>
                                <option value="<%= c %>"><%= c %></option>
                            <% } %>
                        </select>
                    </div>
                </div>

                <div class="col-md-3 col-sm-12"></div>
            </div>

            <div class="row">
                <div class="col-md-3 col-sm-12"></div>

                <div class="col-md-6 col-sm-12 mt-2">
                    <!-- input cittaUniversitaria -->
                    <!-- riempito dinamicamente alla scelta dell'Universita -->
                    <div class="form-outline mb-4" id="Universita">
                        <label class="form-check-label" for="Universita">Seleziona la tua Universit&agrave;:</label> </br>
                        <select class="form-select" id="university" name="university" aria-label="Default select example">
                            <option value="" disabled selected>Seleziona un'opzione...</option>
                            
                        </select>
                    </div>
                </div>

                <div class="col-md-3 col-sm-12"></div>
            </div>

            <div class="row">
                <div class="col-md-3 col-sm-12"></div>

                <div class="col-md-6 col-sm-12 mt-2">
                    <!-- input corso di laurea -->
                    <!-- riempito dinamicamente alla scelta dell'Universita -->
                    <div class="form-outline mb-4" id="Corso">
                        <label class="form-check-label" for="Corso">Seleziona il tuo corso di laurea:</label> </br>
                        <select class="form-select" id="course" name="course" aria-label="Default select example">
                            <option value="" disabled selected>Seleziona un'opzione...</option>

                        </select>
                    </div>
                </div>

                <div class="col-md-3 col-sm-12"></div>
            </div>

            <div class="row">
                <div class="col-md-3 col-sm-12"></div>

                <div class="col-md-6 col-sm-12 mt-2">
                    <!-- input corso di laurea -->
                    <!-- riempito dinamicamente alla scelta dell'Universita -->
                    <div class="form-outline mb-4" id="Piano">
                        <label class="form-check-label" for="Piano">Seleziona il tuo piano formativo:</label></br>
                        <select class="form-select" id="piano" name="piano" aria-label="Default select example">
                            <option value="" disabled selected>Seleziona un'opzione...</option>
                        </select>
                    </div>
                </div>

                <div class="col-md-3 col-sm-12"></div>
            </div>
    
            <div class="row">
                <div class="col-md-5 col-sm-12"></div>

                <div class="col-md-2 col-sm-12 mt-2">
                    <!-- Submit button -->
                    <div class="form-outline mb-4 text-center">
                        <button class="btn btn-primary mb-2 registration-btn" type="submit" id="button">Registrati</button>
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
