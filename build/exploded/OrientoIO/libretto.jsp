<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
// 1) Caricamento del Database se non è stato caricato
if(application.getAttribute("db") == null) {
	DatabaseMock db = new DatabaseMock();
	application.setAttribute("db", db);
}

// 2) Prendere il Database
DatabaseMock db = (DatabaseMock)application.getAttribute("db");

// 3) Se non si è fatto il login si torna alla pagina di login
// Attributo user contiene utente oppure studente universitario in base a "ruolo"
// Attributo username contiene l'username
// Questi tre attributi vanno impostati in fase di login

if(session.getAttribute("user") == null || session.getAttribute("ruolo") == null || session.getAttribute("username") == null) {
	response.sendRedirect("login.jsp");
	return;
}

// 4) Check che l'user abbia i permessi per accedere alla pagina
// Per pagine accessibili da Utente check che non sia amministratore
// Per pagine accessibili a StudenteUniversitario check che sia "studente"
String ruolo = (String) session.getAttribute("ruolo");
String username = (String) session.getAttribute("username");

// Questa pagina è accessibile solo a studenti
if(!ruolo.equals("studente")) {
	response.sendRedirect("login.jsp");
	return;
}

// 5) Check che lo studente non sia bannato
if(ruolo.equals("studente") && 
		((StudenteUniversitario) session.getAttribute("user"))
		.getRestrizione() != null &&
		((StudenteUniversitario) session.getAttribute("user"))
		.getRestrizione().getTipoRestrizione().equals(TipoRestrizione.BAN)){ 
	response.sendRedirect("login.jsp");
	return;
}

// 6) Per pagine recensione check che lo studente non sia bloccato in scrittura


// 7) Prendere lo studente/utente dalla sessione e iniziare a lavorare
StudenteUniversitario s = (StudenteUniversitario) session.getAttribute("user");
Libretto libretto = s.getLibretto();
int CFU_tot = s.getPianoFormativo().getCorso().getTipo() == TipoCorso.TRIENNALE ? 180 : s.getPianoFormativo().getCorso().getTipo() == TipoCorso.MAGISTRALE ? 120 : 300;

if(libretto == null) {
	response.sendRedirect("login.jsp");
	return;
}

NumberFormat formatter = NumberFormat.getInstance(Locale.ITALY);
formatter.setMaximumFractionDigits(2);
%>

    <!doctype html>
    <html lang="en">
    <head>
      <title>Gestione Libretto</title>
      <!-- Required meta tags -->
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

      <!-- JQuery -->
      <script src="./scripts/libs/jquery-1.12.3.min.js"></script>

      <!-- Script -->
      <script src="./scripts/libretto/libretto.js" defer></script>
    
      <!-- Bootstrap CSS v5.2.1 -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js" defer></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" defer></script>
      <link rel="stylesheet" href="./styles/libretto.css">
      <!-- Bootstrap Icons -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" rel="stylesheet">
      <script src="https://cdn.jsdelivr.net/npm/chart.js" defer></script>
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
        <div class="container-fluid py-3">
            <div class="row pt-3">
            </div>
            <div class="container libretto-cont my-3 rounded">
              <div class="row">
                  <div class="col-sm-12">
                      <h3 class="text-center pt-4 stats">Ecco il tuo Libretto</h3>
                      <h4 class="text-center pt-2 stats">Di seguito potrai vedere lo stato del tuo percorso di studi.</h4>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-6 col-sm-12 text-center mt-3">
                    <!-- Button Triggers Modal -->
                    <button class="btn btn-v" id="add-modal-btn" data-bs-toggle="modal" data-bs-target="#addModal">Aggiungi Voto</button>

                    <!-- Modal -->
                    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Registra un Esame</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3 text-start">
                                    <label for="esame" class="form-label">Esame</label>
                                    <select class="form-select form-select" name="esame" id="esame">
                                        <option value="0">Nome esame</option>
                                        <%  List<Esame> esami = s.getPianoFormativo().getEsami();
                                            for(int i = 0; i < esami.size(); i++) { %>
                                            <option value="<%=i+1%>"><%= esami.get(i).getNome()%></option>
                                        <%}%>
                                    </select>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6 text-start">
                                        <div class="mb-3">
                                          <label for="voto" class="form-label">Voto</label>
                                          <input type="text"
                                            class="form-control" name="voto" id="voto" aria-describedby="helpId" placeholder="es. 30" required>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 text-start">
                                        <div class="mb-3">
                                            <label for="voto" class="form-label">CFU</label>
                                            <input type="text"
                                              class="form-control" name="cfu" id="cfu" aria-describedby="helpId" placeholder="es. 9" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6 text-start">
                                        <div class="form-check">
                                          <input class="form-check-input" type="checkbox" value="lode" id="lode">
                                          <label class="form-check-label" for="lode">
                                            Lode
                                          </label>
                                          <div class="error-div" id="error-div" hidden>
                                            <p>La lode può essere impostata solo se il voto è 30!</p>
                                          </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6"></div>
                                </div>
                            </div>
                            <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Chiudi</button>
                            <button type="button" class="btn btn-primary" id="register-btn" data-bs-dismiss="modal">Registra</button>
                            </div>
                        </div>
                        </div>
                    </div>
                  </div>
                  <div class="col-md-6 col-sm-12 text-center mt-3">
                    <!-- Button Triggers Modal -->
                    <button class="btn btn-v" id="preview-modal-btn" data-bs-toggle="modal" data-bs-target="#previewModal">Proietta Voto</button>

                    <!-- Preview Modal -->
                    <div class="modal fade" id="previewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Proietta un voto</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-6 text-start">
                                        <div class="mb-3">
                                          <label for="voto-preview" class="form-label">Voto</label>
                                          <input type="text"
                                            class="form-control" name="voto-preview" id="voto-preview" aria-describedby="helpId" placeholder="es. 30">
                                        </div>
                                    </div>
                                    <div class="col-sm-6 text-start">
                                        <div class="mb-3">
                                            <label for="cfu-preview" class="form-label">CFU</label>
                                            <input type="number"
                                              class="form-control" name="cfu-preview" id="cfu-preview" aria-describedby="helpId" placeholder="es. 9">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6 text-start">
                                        <div class="form-check">
                                          <input class="form-check-input" type="checkbox" value="lode-preview" id="lode-preview">
                                          <label class="form-check-label" for="lode-preview">
                                            Lode
                                          </label>
                                          <div class="error-div" id="error-div-preview" hidden>
                                            <p>La lode può essere impostata solo se il voto è 30!</p>
                                          </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6"></div>
                                </div>
                            </div>
                            <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Chiudi</button>
                            <button type="button" class="btn btn-primary" id="preview-btn" data-bs-dismiss="modal">Proietta</button>
                            </div>
                        </div>
                        </div>
                    </div>
                    <!-- Modal Proiezione  -->
                    <div class="modal fade" id="proiezione-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                      <div class="modal-dialog">
                      <div class="modal-content">
                          <div class="modal-header">
                          <h1 class="modal-title fs-5" id="exampleModalLabel">Ecco la tua Proiezione</h1>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                              <div class="row">
                                <div class="col-sm-12">
                                  <p>Registrando questo voto nel tuo libretto, le tue statistiche saranno le seguenti: </p> 
                                </div>
                              </div>
                              <div class="row px-3">
                                <div class="col-sm-12 col-md-4 text-center">
                                  <h5>CFU</h5>
                                </div>
                                <div class="col-sm-12 col-md-4 text-center">
                                  <h5>MEDIA</h5>
                                </div>
                                <div class="col-sm-12 col-md-4 text-center">
                                  <h5>BASE DI LAUREA</h5>
                                </div>
                              </div>
                              <div class="row px-3">
                                <div class="col-sm-12 col-md-4 text-center">
                                  <h6 id="proiezione-cfu"></h6>
                                </div>
                                <div class="col-sm-12 col-md-4 text-center">
                                  <h6 id="proiezione-media"></h6>
                                </div>
                                <div class="col-sm-12 col-md-4 text-center">
                                  <h6 id="proiezione-base"></h6>
                                </div>
                              </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                <div class="row main-row"> 
                    <div class="list-col col-md-7 col-sm-12 pt-4">
                    <%
	                if(libretto.getEsamiSvolti().isEmpty()) { %>
	                <div class="col-sm-12 d-flex align-items-center justify-content-center">
	                	<h6>Aggiungi un esame alla tua lista!</h6>
	                </div>
	                <%}  else {
	                	for(EsameSvolto e : libretto.getEsamiSvolti()) { %>
	                		<div class="ms-3 job-box d-md-flex align-items-center justify-content-between mb-30">
	                   <div class="job-left my-4 d-md-flex align-items-center flex-wrap">
	                       <div class="img-holder mr-md-4 mb-md-0 mb-4 mx-auto mx-md-0 d-md-none d-lg-flex">
	                           <%=e.getVoto() == 30 && e.getLode() ? "30L" : e.getVoto() %>
	                       </div>
	                       <div class="job-content">
	                           <h5 class="text-center ms-5"><%= e.getEsame().getNome() %></h5>
	                           <ul class="d-md-flex flex-wrap text-capitalize ff-open-sans">
	                               <li class="mr-md-4">
	                                   <i class="zmdi zmdi-pin ms-3"></i>CFU:  <%= e.getEsame().getCFU() %>
	                               </li>
	                           </ul>
	                       </div>
	                   </div>
	                   <div class="job-right my-4 flex-shrink-0 me-5">
	                     <div class="row">
	                       <div class="col-sm-6 pe-0 me-0">
	                         <button class="btn btn-warning modify-btn" value="<%= e.getEsame().getCFU()%>" name="<%= e.getEsame().getNome()%>">
	                           <i class="bi bi-pencil-square"></i>
	                         </button>
	                       </div>
	                       <div class="col-sm-6">
	                         <button data-bs-toggle="modal" data-bs-target="#modifyModal" class="btn btn-danger remove-btn" value="<%= e.getEsame().getNome()%>">
	                           <i class="bi bi-trash"></i>
	                         </button>
	                       </div>
	                       
	                     </div>
	                   </div>
	               </div>
	                	<%} %>
	           
                   
        
                    <%} %>
                    </div>
                    <!-- Modify Modal -->
                    <div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                      <div class="modal-dialog">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Modifica il tuo Voto</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                            <div class="row">
                              <div class="mb-3">
                                <label for="esame-modify" class="form-label">Esame</label>
                                <input type="text"
                                class="form-control" name="esame-modify" id="esame-modify" aria-describedby="helpId" placeholder="" readonly required>
                              </div>
                              <div class="col-sm-6 text-start">
                                <div class="mb-3">
                                  <label for="voto-modify" class="form-label">Voto</label>
                                  <input type="text"
                                  class="form-control" name="voto-modify" id="voto-modify" aria-describedby="helpId" placeholder="es. 30" required>
                                </div>
                              </div>
                              <div class="col-sm-6 text-start">
                                <div class="mb-3">
                                  <label for="cfu-modify" class="form-label">CFU</label>
                                  <input type="number"
                                  class="form-control" name="cfu-modify" id="cfu-modify" aria-describedby="helpId" readonly>
                                </div>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col-sm-6 text-start">
                                <div class="form-check">
                                  <input class="form-check-input" type="checkbox" value="lode-modify" id="lode-preview">
                                  <label class="form-check-label" for="lode-modify">Lode</label>
                                  <div class="error-div" id="error-div-modify" hidden>
                                    <p>La lode può essere impostata solo se il voto è 30!</p>
                                  </div>
                                </div>
                              </div>
                              <div class="col-sm-6"></div>
                            </div>
                          </div>
                          <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Chiudi</button>
                            <button type="button" class="btn btn-primary" id="save-modify-btn" data-bs-dismiss="modal">Salva</button>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Separatore -->
                    <div class="col-md-1"></div>

                    <!-- Sezione Statistiche -->
                    <div class="col-md-4 col-sm-12">
                        <div class="row text-center">
                            <div class="col-sm-12 text-center pt-2">
                                <h5 class="pt-4 stats">CFU: <%= libretto.getCFU() %> / <%= CFU_tot %></h5>
                                <div class="container">
                                    <canvas id="myChart"></canvas>
                                  </div>                              
                            </div>
                        </div>
                        <div class="row pt-5">
                            <div class="col-md-6 col-sm-12 text-center pt-2">
                                <h4 class="stats">Media</h4>
                                <p class="mb-lau"><%= formatter.format(libretto.getMedia()) %></p>
                            </div>
                            <div class="col-md-6 col-sm-12 text-center pt-2 pe-4">
                                <h4 class="stats">Base di Laurea</h4>
                                <p class="mb-lau"><%= formatter.format(libretto.getBaseDiLaurea()) %></p>
                            </div>
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
    
    <script defer>
        window.onload = function() {
        var canvas = document.getElementById("myChart");
        if (canvas) {
          var ctx = canvas.getContext("2d");
          canvas.setAttribute("width", 10);
          canvas.setAttribute("height", 10);
        var ctx = document.getElementById("myChart").getContext("2d");
        var data = {
        labels: ["Sostenuti", "Da sostenere"],
        datasets: [
            {
            label: "CFU",
            data: [<%= libretto.getCFU()%>, <%= CFU_tot - libretto.getCFU()%>],
            backgroundColor: ["#264653", "#99CEC7"],
            hoverOffset: 4,
            borderWidth: 0,
            animation: {
                animateScale: true
            }
            }
        ]
        };
        var myChart = new Chart(ctx, {
        type: "pie",
        data: data,
        options: {
            responsive: true,
            plugins: {
            legend: {
                position: "top",
             },
            title: {
                display: true,
                text: ""
            }
            }
        }
        });
    }};
    </script>  
    </body>
    
    </html>