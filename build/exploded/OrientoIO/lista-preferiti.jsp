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
    <title>Lista Preferiti</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS v5.2.1 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <!-- CSS -->
    <link rel="stylesheet" href="./styles/lista-preferiti.css">

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
    <script src="./scripts/lista-preferiti/lista-preferiti.js" defer></script>
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
            <!-- Page Title -->
            <div class="row">
                <div class="col-sm-12 text-center">
                    <h4>Ecco la tua Lista dei Corsi Preferiti</h4>
                    <h5>Qui potrai visualizzare i vari Corsi da te inseriti oppure modificare tale lista.</h5>
                </div>
            </div>

            <!-- Barra per aggiungere un corso ai preferiti -->
            <div class="row justify-content-center">
                <div class="col-sm-12 col-md-9 py-3">
                    <input type="text" class="form-control text-input" name="corso" id="search-corso" aria-describedby="helpId" placeholder="Cerca un Corso">
                </div>
                <div class="col-sm-12 col-md-3 py-3 justify-content-center">
                    <button type="button" class="btn add-btn" id="add-btn">Cerca</button>
                </div>
            </div>
            <div class="container my-2" id="search-results">

            </div>

            <!-- Corsi Preferiti -->
            <div class="row">
                <%for(CorsoDiLaurea c : list) { %>
                    <div class="col-sm-12 col-md-3 py-3 d-flex justify-content-center align-items-center">
                        <div class="card shadow" style="width: 18rem;">
                            <div class="card-body rounded">
                              <h5 class="card-title text-center"><%= c.getNome() %></h5>
                              <p class="card-text text-center"><%= c.getUniversita().getNome() %></p>
                              <hr>
                              <ul class="list-group list-group-flush">
                                <li class="list-group-item text-center"><%= c.getTipo().toString().replaceAll("_", " ") %></li>
                              </ul>
                              <hr>
                             <button data-bs-toggle="modal" data-bs-target="#<%=c.toString().replaceAll(" ", "_").replaceAll(".", "_")%>" class="btn go-btn">Scopri di più</button>
                             <button class="btn mt-3 btn-danger del-btn" value="<%=c.getUniversita().getNome() + "____" + c.getNome() %>">Rimuovi</button>
                            </div>
                        </div>
                    </div>

                    <!-- View Per le informazioni sul Corso-->
                    <div class="modal modal-xl fade" id="<%=c.toString().replaceAll(" ", "_").replaceAll(".", "_")%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h1 class="modal-title fs-5" id="">Scheda del Corso</h1>
                              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                              <div class="row">
                                <div class="col-sm-8">
                                  <h2><%= c.getNome() %></h2>
                                  <h3><%= c.getUniversita().getNome() %></h3>
                                </div>
                                <div class="col-sm-4 d-flex justify-content-end align-items-center pe-4">
                                </div>
                              </div>
                                <hr>
                
                                <div class="container">
                                    <div class="row mb-3">
                                        <div class="col-md-4">
                                            <h5>Tipo</h5>
                                            <%= c.getTipo().toString().replaceAll("_", " ")%>
                                        </div>
                                        <div class="col-md-4">
                                            <h5>Accesso</h5>
                                            <%= c.getAccesso()%>
                                        </div>
                                        <div class="col-md-4">
                                            <h5>Lingua</h5>
                                            <%= c.getLingua()%>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-4">
                                            <h5>Classe di Corso</h5>
                                            <%= c.getClasseDiCorso()%>
                                        </div>
                                        <div class="col-md-4">
                                            <h5>Dipartimento</h5>
                                            <%= c.getDipartimento()%>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-4">
                                            <h5>Coordinatore</h5>
                                            <%= c.getCoordinatore()%>
                                        </div>
                                        <div class="col-md-4">
                                            
                                        </div>
                                        <div class="col-md-4">
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-sm-12 pt-2 pb-2 text-center">
                                        <h6>Esplora il Piano Didattico del Corso!</h6>
                                        
                                        <!-- for per ogni piano formativo -->
                                        <%for(PianoFormativo f : c.getPianiFormativi()){ %>
                                        <div class="accordion" id="<%=f.getAnnoImmatricolazione().replace(" ", "_")%>">
                                          <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingOne">
                                              <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#<%=f.getAnnoImmatricolazione().replace(" ", "_")%>" aria-expanded="true" aria-controls="collapseOne">
                                                Piano Formativo per Studenti Immatricolati nell'A.A. <%= f.getAnnoImmatricolazione() %>
                                              </button>
                                            </h2>
                                            <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#<%=f.getAnnoImmatricolazione().replace(" ", "_")%>">
                                              <div class="accordion-body">
                                                <div class="container">
                                                  <div class="row pt-2">
                                                      <!--  <div class="col-sm-12 text-start">
                                                          <h5>Primo Anno</h5>
                                                      </div>-->
                                                  </div>
                                                  <div class="row mb-2 ms-2 me-2 mt-2" style="border-bottom-width: 0.5px; border-bottom-style: solid;">
                                                      <div class="col-sm-4 ps-3 text-start">
                                                          Nome Esame
                                                      </div>
                                                      <div class="col-sm-2 text-center">
                                                          Periodo
                                                      </div>
                                                      <div class="col-sm-2 text-center">
                                                          SSD
                                                      </div>
                                                      <div class="col-sm-2 text-center">
                                                          CFU
                                                      </div>
                                                      <div class="col-sm-2 text-center">
                                                          
                                                      </div>
                                                  </div>
                                                  
                                                  <!-- for per ogmi esame -->
                                                  <%for(Esame e : f.getEsami()){ %>
                                                  <div class="row pb-2 pt-2 exam-row d-flex align-items-center">
                                                      <div class="col-sm-4 ps-3 text-start">
                                                          <%= e.getNome() %>
                                                      </div>
                                                      <div class="col-sm-2 text-center">
                                                          <%= e.getPeriodo() %>
                                                      </div>
                                                      <div class="col-sm-2 text-center">
                                                          <%= e.getSSO() %>
                                                      </div>
                                                      <div class="col-sm-2 text-center">
                                                          <%= e.getCFU() %>
                                                      </div>
                                                      <div class="col-sm-2 text-center">
                                                          <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">Scheda Esame</button>
                                                          <!-- bisogna colegare questo alla view dell'esame -->
                                                      </div>
                                                  </div>
                                                 <%} %> <!-- fine for esami -->
                                                  
                                                  
                                                </div>
                                              </div>
                                            </div>
                                          </div>
                                          </div>
                                          <%} %> <!-- fine for piano formativo -->
                                        
                
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-12 pt-2 pb-2">
                                        <h6>Per maggiori informazioni esplora il sito ufficiale del Corso</h6>
                                        <a href="#"><%= c.getLinkCorso() %></a>
                                    </div>
                                </div>
                                <hr class="mt-3">
                                <div class="row mt-3">
                                  <div class="col-sm-12 pt-2 pb-2 d-flex align-items-center justify-content-center">
                                    <h6>Vuoi sapere cosa pensano gli studenti di questo Corso di Laurea?</h6>
                                  </div>
                                </div>
                                <div class="row mt-2">
                                  <div class="col-sm-12 pt-2 pb-2 d-flex align-items-center justify-content-center">
                                      <form>
                                      <input type="text" hidden name="recensioni" value="<%= c.getNome().replace(" ", "_")%>_<%= c.getUniversita().getNome().replace(" ", "_") %>">
                                      <button type="submit" class="btn btn-success" >Leggi le Recensioni sul Corso</button>
                                      </form>
                                  </div>
                                </div>
                            </div>
                          </div>
                        </div>
                      </div>
                <%} %>
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