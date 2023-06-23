<%@page import="model.*"%>
<%@page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<% 
if(application.getAttribute("db") == null){
	DatabaseMock db = new DatabaseMock();
	application.setAttribute("db", db);
}

DatabaseMock db = (DatabaseMock) application.getAttribute("db");

if(session.getAttribute("user") == null || session.getAttribute("ruolo") == null || session.getAttribute("username") == null) {
	response.sendRedirect("login.jsp");
	return;
}

String ruolo = (String) session.getAttribute("ruolo");
String username = (String) session.getAttribute("username");

if(ruolo.equals("amministratore")) {
	response.sendRedirect("HomeAmministratore.jsp");
	return;
}else{

	Utente utente = (Utente) session.getAttribute("user");
	
	List<CorsoDiLaurea> corsiRicercati = new ArrayList<>();
	if(request.getParameter("corsoRicercato")!= null){
		String corsoRicercato = (String) request.getParameter("corsoRicercato");
		
		List<CorsoDiLaurea> corsi = db.getCorsi();
		
		for(CorsoDiLaurea c : corsi){
			if(c.getNome().toLowerCase().contains(corsoRicercato.toLowerCase()))
				corsiRicercati.add(c);
		}
		//System.out.println(corsiRicercati);
		
	}
		
%>
<html>
<head>
<title>Ricerca Corso</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" rel="stylesheet">

    <link rel="stylesheet" href="./styles/ricercaCorso.css">
    
    <script src="./scripts/libs/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="./scripts/ricercaCorso.js" defer></script>
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
            <div class="col-sm-12 col-md-3 pt-2 pb-2 sidebar shadow">
                <h3 class="text-center">Ricerca</h3>
                <div class="container">
                    <div class="mt-2 mb-3">
                    	<form action="RicercaCorso.jsp" method="GET">
                      		<label for="" class="form-label h6">Corso</label>
                      		<input type="text" class="form-control" name="corsoRicercato" id="corsoRicercato" aria-describedby="helpId" placeholder="es. Ingegneria Informatica">
                      		<button type="submit" class="btn search-btn mt-2" id="eseguiRicerca"><i class="bi bi-search"></i> &nbsp; Ricerca Corso</button>
                    	</form>
                    </div>
                </div>
            </div>
            
            <div class="col-sm-12 col-md-9 pb-4">
                <h4 class="text-center mt-2 mb-2">Ecco i risultati della tua ricerca</h4>
                <div class="container mt-3">
               	<!-- Risultati ricerca -->
               	
               	<!-- for per ogni corso -->
               	<div class="row justify-content-center align-items-center g-2 mt-2">
               	<%for(CorsoDiLaurea cc : corsiRicercati){ %>
                        <div class="col-sm-12 col-md-4 d-flex justify-content-center align-items-center">
                            <div class="card shadow" style="width: 18rem;">
                                <div class="card-body">
                                  <h5 class="card-title text-center"><%=cc.getNome() %></h5>
                                  <p class="card-text text-center"><%= cc.getUniversita().getNome() %></p>
                                </div>
                                <ul class="list-group list-group-flush">
                                  <li class="list-group-item"><b>Tipo:</b> <%= cc.getTipo() %></li>
                                  <li class="list-group-item"><b>Sede:</b> <%= cc.getUniversita().getCitta().getNomeCitta() %></li>
                                  <li class="list-group-item"><b>Lingua:</b> <%= cc.getLingua() %></li>
                                  <li class="list-group-item"><b>Accesso:</b> <%= cc.getAccesso()%></li>
                                </ul>
                                <div class="card-body">
                                  <button class="btn explore-btn" data-bs-toggle="modal" data-bs-target="#<%= cc.getNome().replace(" ", "_") %>_<%= cc.getUniversita().getNome().replace(" ", "_")%>">Esplora il Corso</button>
                                </div>
                              </div>
                        </div>
                	
                <%} %>
                </div> <!-- div row -->
            </div>
        </div>
    </div>

	<!-- stesso for per ogni corso, ricordati di collegare target bottone sopra con questo id -->
	<%for(CorsoDiLaurea cc : corsiRicercati){ %>
    <div class="modal modal-xl fade" id="<%= cc.getNome().replace(" ", "_")%>_<%= cc.getUniversita().getNome().replace(" ", "_") %>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="<%= cc.getNome().replace(" ", "_")%>_<%= cc.getUniversita().getNome().replace(" ", "_") %>">Scheda del Corso</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="row">
                <div class="col-sm-8">
                  <h2><%=cc.getNome() %></h2>
                  <h3><%= cc.getUniversita().getNome() %></h3>
                </div>
                <div class="col-sm-4 d-flex justify-content-end align-items-center pe-4">
                  <button type="button" value="<%=cc.getUniversita().getNome() + "____" + cc.getNome()  %>" class="btn btn-success add-to-favorite-button" id="aggiungiPreferito">Aggiungi ai Preferiti</button>
                </div>
              </div>
                <hr>

                <div class="container">
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <h5>Tipo</h5>
                            <%= cc.getTipo() %>
                        </div>
                        <div class="col-md-4">
                            <h5>Accesso</h5>
                            <%= cc.getAccesso()%>
                        </div>
                        <div class="col-md-4">
                            <h5>Lingua</h5>
                            <%= cc.getLingua()%>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <h5>Classe di Corso</h5>
                            <%= cc.getClasseDiCorso()%>
                        </div>
                        <div class="col-md-4">
                            <h5>Dipartimento</h5>
                            <%= cc.getDipartimento()%>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <h5>Coordinatore</h5>
                            <%= cc.getCoordinatore()%>
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
                        <%for(PianoFormativo f: cc.getPianiFormativi()){ %>
                        <div class="accordion" id="<%= f.getAnnoImmatricolazione().replace("/", "_") %>">
                          <div class="accordion-item">
                            <h2 class="accordion-header" id="headingOne">
                              <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#<%= f.getAnnoImmatricolazione().replace("/", "_") %>" aria-expanded="true" aria-controls="collapseOne">
                                Piano Formativo per Studenti Immatricolati nell'A.A. <%= f.getAnnoImmatricolazione() %>
                              </button>
                            </h2>
                            <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#<%= f.getAnnoImmatricolazione().replace("/", "_") %>">
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
                                  
                                  <!-- for per ogni esame -->
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
                                          <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#<%= cc.getNome().replace(" ", "_")%>_<%= cc.getUniversita().getNome().replace(" ", "_") %>_<%=f.getAnnoImmatricolazione().replace("/", "_")%>_<%=e.getNome().replace(" ", "_")%>">Scheda Esame</button>
                                          <!-- bisogna collegare questo alla view dell'esame -->
                                      </div>
                                  </div>
                                  
                                  <%} %> <!-- fine for per ogni esame -->
                                  
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
                        <a href="<%= cc.getLinkCorso() %>"><%= cc.getLinkCorso() %></a>
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
                  	<div class="card-body">
                  		<button class="btn explore-btn" data-bs-toggle="modal" data-bs-target="#recensioni_<%= cc.getNome().replace(" ", "_")%>_<%= cc.getUniversita().getNome().replace(" ", "_") %>">Leggi le Recensioni sul Corso</button>
                    </div>
                  </div>
                </div>
                
                

            </div>
          </div>
        </div>
      </div>
      
      
      <% for(PianoFormativo f: cc.getPianiFormativi()){
                          for(Esame e : f.getEsami()){ %>
                          <!-- view lettura scheda esame -->
					                <div class="modal modal-xl fade" id="<%= cc.getNome().replace(" ", "_")%>_<%= cc.getUniversita().getNome().replace(" ", "_") %>_<%=f.getAnnoImmatricolazione().replace("/", "_")%>_<%=e.getNome().replace(" ", "_")%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  					<div class="modal-dialog">
					    					<div class="modal-content">
					      						<div class="modal-header">
					        						<h5 class="modal-title" id="staticBackdropLabel">Ecco tutte le informazioni per l'esame  <%=e.getNome() %></h5>
					        						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      						</div>
					      						
					      						<div class="modal-body">
					        					
					        						<div class="row mb-2 ms-2 me-2 mt-2">
					                                      <div class="col-md-3 text-start">
					                                          <strong>SSD:</strong> <%=e.getSSO() %>
					                                      </div>
					                                      <div class="col-md-3 text-start">
					                                          <strong>CFU:</strong> <%=e.getCFU() %>
					                                      </div>
					                                      <div class="col-md-3 text-start">
					                                          <strong>Periodo:</strong> <%=e.getPeriodo() %>
					                                      </div>
					                                      <div class="col-md-3 text-start">
					                                          <strong>Anno:</strong> <%=e.getAnno() %>
					                                      </div>
					                                 </div>
					                                  
					                                  <hr>
											                <div class="row">
											                    <div class="col-sm-12 pt-2 pb-2">
											                        <h6>Per maggiori informazioni esplora il sito ufficiale di questo esame</h6>
											                        <a href="<%= e.getLinkEsame() %>"><%= e.getLinkEsame() %></a>
											                    </div>
											                </div>
											                <hr class="mt-3">
											                <div class="row mt-3">
											                  <div class="col-sm-12 pt-2 pb-2 d-flex align-items-center justify-content-center">
											                    <h6>Vuoi sapere cosa pensano gli studenti di questo Esame?</h6>
											                  </div>
											                </div>
											                <div class="row mt-2">
											                  <div class="col-sm-12 pt-2 pb-2 d-flex align-items-center justify-content-center">
											                  	<div class="col-sm-2 text-center">
					                                          		<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#recensioni_<%= cc.getNome().replace(" ", "_")%>_<%= cc.getUniversita().getNome().replace(" ", "_") %>_<%=f.getAnnoImmatricolazione().replace("/", "_")%>_<%=e.getNome().replace(" ", "_")%>">Leggi le recensioni degli Studenti per questo esame</button>
					                                      		</div>
											                  </div>
											                </div>
					                           
					      						</div>
					      					
					    					</div>
					  					</div>
									</div> 
									
									<!-- view lettura recensioni dell'esame -->
									<div class="modal modal-xl fade" id="recensioni_<%= cc.getNome().replace(" ", "_")%>_<%= cc.getUniversita().getNome().replace(" ", "_") %>_<%=f.getAnnoImmatricolazione().replace("/", "_")%>_<%=e.getNome().replace(" ", "_")%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  					<div class="modal-dialog">
					    					<div class="modal-content">
					      						<div class="modal-header">
					        						<h5 class="modal-title" id="staticBackdropLabel">Ecco le recensioni che gli studenti hanno dato per <%=e.getNome() %></h5>
					        						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      						</div>
					      						
					      						<div class="modal-body">
					        					
					        						<div class="row mb-2 ms-2 me-2 mt-2" style="border-bottom-width: 0.5px; border-bottom-style: solid;">
					                                      <div class="col-md-3 text-start">
					                                          Testo recensione
					                                      </div>
					                                      <div class="col-md-1 text-start">
					                                          Voto preso
					                                      </div>
					                                      <div class="col-md-2 text-start">
					                                          Tempo di Studio <br> (in ore)
					                                      </div>
					                                      <div class="col-md-2 text-start">
					                                          Valutazione del Professore 
					                                      </div>
					                                      <div class="col-md-2 text-start">
					                                          Studente
					                                      </div>
					                                 </div>
					                                 <hr>
					                                  
					                            <!-- for per ogni recensione del corso trovata -->
					                            <%for(RecensioneEsame re: e.getRecensioni()){ 
					                            	if( re.getEsame().getNome().equals(e.getNome()) && re.getEsame().getLinkEsame().equals(e.getLinkEsame())){
					                            
					                            %>
					        						<div class="row pb-2 pt-2 exam-row d-flex align-items-center">
					                                      <div class="col-md-3 text-start">
					                                          <%= re.getTestoRecensione() %>
					                                      </div>
					                                      <div class="col-md-1 text-start">
					                                          <%= re.getVoto() + (re.getLode()? "L" : "") %>
					                                      </div>
					                                      <div class="col-md-2 text-start">
					                                          <%= re.getTempoDiStudio().toHours() %>
					                                      </div>
					                                      <div class="col-md-2 text-start">
					                                          <%= re.getValutazioneProfessore() %> /5
					                                      </div>
					                                      <div class="col-md-2 text-start">
					                                          <%= re.getStudente().getUsername() %>
					                                      </div>
					                                      
					                                      <div class="col-md-2 text-start">
					                                      	<form action="SegnalaRecensioneEsame.jsp" method="POST">
					                                      		<input type="text" name="nomeEsame" value="<%= e.getNome()%>" hidden>
					                                      		<input type="text" name="link" value="<%= e.getLinkEsame()%>" hidden>
					                                      		<input type="text" name="usernameStudente" value="<%= re.getStudente().getUsername()%>" hidden>
					                                      		<button type="submit" class="btn btn-success">Segnala recensione</button>
					                                      	</form> 
					                                      </div>
					                                      
					                                  </div>
					                                  <hr>
					        					
					        					<%} 
					        					}%>
					      						</div>
					      					
					    					</div>
					  					</div>
									</div> 
									
									
									
									
		<%} }%> <!-- fine doppio for -->
      
      
      
      
      
      <!-- view lettura recensioni corso -->
                <div class="modal modal-xl fade" id="recensioni_<%= cc.getNome().replace(" ", "_")%>_<%= cc.getUniversita().getNome().replace(" ", "_") %>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  					<div class="modal-dialog">
    					<div class="modal-content">
      						<div class="modal-header">
        						<h5 class="modal-title" id="staticBackdropLabel">Ecco le recensioni che gli studenti hanno dato per <%=cc.getNome() %></h5>
        						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      						</div>
      						
      						<div class="modal-body">
        					
        						<div class="row mb-2 ms-2 me-2 mt-2" style="border-bottom-width: 0.5px; border-bottom-style: solid;">
                                      <div class="col-md-3 text-start">
                                          Testo recensione
                                      </div>
                                      <div class="col-md-1 text-start">
                                          Qualit&agrave; dell'insegnamento
                                      </div>
                                      <div class="col-md-2 text-start">
                                          Opportunit&agrave; offerte
                                      </div>
                                      <div class="col-md-2 text-start">
                                          Sbocchi lavorativi
                                      </div>
                                      <div class="col-md-2 text-start">
                                          Studente
                                      </div>
                                 </div>
                                 <hr>
                                  
                            <!-- for per ogni recensione del corso trovata -->
                            <%for(RecensioneCorso rv: cc.getRecensioni()){ 
                            	if(rv.getCorso().getNome().equals(cc.getNome()) && rv.getCorso().getUniversita().getNome().equals(cc.getUniversita().getNome())){
                            
                            %>
        						<div class="row pb-2 pt-2 exam-row d-flex align-items-center">
                                      <div class="col-md-3 text-start">
                                          <%= rv.getTestoRecensione() %>
                                      </div>
                                      <div class="col-md-1 text-start">
                                          <%= rv.getQualitaInsegnamento() %> /5
                                      </div>
                                      <div class="col-md-2 text-start">
                                          <%= rv.getOpportunitaOfferte() %>
                                      </div>
                                      <div class="col-md-2 text-start">
                                          <%= rv.getSbocchiLavorativi() %>
                                      </div>
                                      <div class="col-md-2 text-start">
                                          <%= rv.getStudente().getUsername() %>
                                      </div>
                                      
                                      <div class="col-md-2 text-start">
                                      	<form action="SegnalaRecensioneCorso.jsp" method="POST">
                                      		<input type="text" name="nomeCorso" value="<%= cc.getNome()%>" hidden="true">
                                      		<input type="text" name="nomeUniversita" value="<%= cc.getUniversita().getNome()%>" hidden="true">
                                      		<input type="text" name="usernameStudente" value="<%= rv.getStudente().getUsername()%>" hidden="true">
                                      		<button type="submit" class="btn btn-success">Segnala recensione</button>
                                      	</form> 
                                      </div>
                                      
                                  </div>
                                  <hr>
        					
        					<%} 
        					}%>
      						</div>
      					
    					</div>
  					</div>
				</div> 

				
     <%} %> <!-- fine for corsi -->
  </main>
  <footer>
        <div class="container-fluid">
            <div class="row py-2">
                <div class="col-sm-12 text-center">
                    <h6>&agrave; 2023 OrientoIO. Tutti i diritti riservati.</h6>
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
<%}%>