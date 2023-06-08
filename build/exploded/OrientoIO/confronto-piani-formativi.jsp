<%@page import="java.util.List"%>
<%@page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

if(application.getAttribute("db") == null) {
	DatabaseMock db = new DatabaseMock();
	application.setAttribute("db", db);
}

DatabaseMock db = (DatabaseMock)application.getAttribute("db");

// Studente Finto per le prove
StudenteUniversitario s = db.getStudenti().get("mandarino87");
session.setAttribute("user", s);
session.setAttribute("ruolo", "studente");
session.setAttribute("username", "mandarino87");

if(session.getAttribute("user") == null || session.getAttribute("ruolo") == null || session.getAttribute("username") == null) {
	response.sendRedirect("login.jsp");
}

String ruolo = (String) session.getAttribute("ruolo");
String username = (String) session.getAttribute("username");

if(ruolo.equals("amministratore")) {
	response.sendRedirect("HomeAmministratore.jsp");
} else if(ruolo.equals("studente") && 
		((StudenteUniversitario) session.getAttribute("user"))
		.getRestrizione() != null &&
		((StudenteUniversitario) session.getAttribute("user"))
		.getRestrizione().getTipoRestrizione().equals(TipoRestrizione.BAN)){ 
	response.sendRedirect("./login.jsp");
}

Utente utente = (Utente) session.getAttribute("user");
List<CorsoDiLaurea> list = utente.getListaPreferiti().getCorsiDiLaurea();
%>

<!doctype html>
<html lang="it">

<head>
    <title>Confronto Piani Formativi - OrientoIO</title>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS v5.2.1 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

    <!-- Style -->
    <link rel="stylesheet" href="./styles/confronto.css">

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
    <script src="./scripts/confronto/confronto.js" defer></script>
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
    <div class="container py-4 box">
        <div class="row my-5 text-center">
            <div class="col-sm-12 mt-2 text-center">
                <h4 class="text-center">Confronta due piani formativi</h4>
            </div>
        </div>

        <!-- prima scelta: Universita -->
        <div class="row  justify-content-start">
            <div class="col-md-6 col-sm-12 mt-2 text-start ps-3">
                <div class="mb-3">
                    <label for="university1" class="form-label px-2">Universit&agrave;</label>
                    <select class="form-select form-select-lg" name="university1" id="university1">
                        <option value="" selected>Seleziona un'universit&agrave;</option>
                        <%
                        	for(String u : db.getUniversita().keySet()) { %>
                        		<option value="<%=db.getUniversita().get(u).getNome()%>""><%=db.getUniversita().get(u).getNome()%></option>
                        	<%
                            }
                        %>
                    </select>
                </div>
            </div>
            
            <div class="col-md-6 col-sm-12 mt-2 text-end justify-content-end pe-3">
                <div class="mb-3">
                    <label for="university1" class="form-label px-2">Universit&agrave;</label>
                    <select class="form-select form-select-lg" name="university2" id="university2">
                        <option value="" selected>Seleziona un'universit&agrave;</option>
                        <%
                        	for(String u : db.getUniversita().keySet()) { %>
                        		<option value="<%=db.getUniversita().get(u).getNome()%>""><%=db.getUniversita().get(u).getNome()%></option>
                        	<%
                            }
                        %>
                    </select>
                </div>
            </div>
        </div>

        <!-- seconda scelta: il nome del corso -->
        <div class="row justify-content-start">
            <div class="col-md-6 col-sm-12 text-start ps-3">
                <div class="mb-3">
                    <label for="university1" class="form-label px-2">Corso Di Laurea</label>
                    <select class="form-select form-select-lg" name="course1" id="course1" disabled>
                        <option value="" selected>Seleziona un Corso di Laurea</option>

                    </select>
                </div>
            </div>

            <div class="col-md-6 col-sm-12 text-end justify-content-end pe-3">
                <div class="mb-3">
                    <label for="university1" class="form-label px-2">Corso Di Laurea</label>
                    <select class="form-select form-select-lg" name="course2" id="course2" disabled>
                        <option value="" selected>Seleziona un Corso di Laurea</option>
                        
                    </select>
                </div>
            </div>
        </div>

        <!-- terza scelta: il piano formativo -->
        <div class="row justify-content-start">
            <div class="col-md-6 col-sm-12 text-start ps-3">
                <div class="mb-3">
                    <label for="university1" class="form-label px-2">Piano Formativo</label>
                    <select class="form-select form-select-lg" name="Piano1" id="Piano1" disabled>
                        <option value="" selected>Seleziona un Piano Formativo</option>
                        
                    </select>
                </div>
            </div>

            <div class="col-md-6 col-sm-12 text-end justify-content-end pe-3">
                <div class="mb-3">
                    <label for="university1" class="form-label px-2">Piano Formativo</label>
                    <select class="form-select form-select-lg" name="Piano2" id="Piano2" disabled>
                        <option value="" selected>Seleziona un Piano Formativo</option>
                        
                    </select>
                </div>
            </div>

        </div>

        <!-- output: piani formativi-->
        <!--generata dinamicamente quando la ultima select è stata selezionata-->
        <div class="row justify-content-start my-5">
            <div class="col-md-1 col-sm-12"></div>
            
            <div class="col-md-5 col-sm-12 px-3 justify-content-end">
                <ul class="list-unstyled" id="result-list-1">
                    
                </ul>
            </div>

            <div class="col-md-5 col-sm-12 px-3 justify-content-center">
                <ul class="list-unstyled" id="result-list-2">
                    
                </ul>
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
  
</body>
</html>