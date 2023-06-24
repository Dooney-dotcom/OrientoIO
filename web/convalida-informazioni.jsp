<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.*" %>
<%@ page import="java.util.List" %>

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
	List<InformazioniCitta> informazioni = db.getInfoCitta();
%>

<!doctype html>
<html lang="en">

<head>
  <title>Convalida Informazioni</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

    <link rel="stylesheet" href="styles/convalida-informazioni.css">

    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
	
	<script type="text/javascript" src="scripts/utils.js"></script>
	<script type="text/javascript" src="scripts/convalidaAJAX.js"></script>
	
	<script src="https://code.jquery.com/jquery-3.6.4.slim.min.js" integrity="sha256-a2yjHM4jnF9f54xUQakjZGaqYs/V1CYvWpoqZzC2/Bw=" crossorigin="anonymous"></script>
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

    <main class="pt-2 pb-2">
        <div class="container main-container shadow rounded">
            <div class="row py-2">
                <div class="col-sm-12 text-center">
                    <h3>Lista delle Informazioni ricevute dagli Utenti</h3>
                </div>
            </div>
            <div class="container">
                <div class="row mb-2 ms-2 me-2 mt-2" style="border-bottom-width: 0.5px; border-bottom-style: solid;">
                    <div class="col-sm-4 ps-3">
                        Inviata da
                    </div>
                    <div class="col-sm-2 text-center">
                        Username
                    </div>
                    <div class="col-sm-6 text-center">
                        Azione
                    </div>
                </div>
                <%
                	for(InformazioniCitta i: informazioni){
                		if(i.getStatoConvalida() == StatoConvalida.IN_ATTESA){
                			String nomeCompleto=i.getStudente().getNome()+" "+i.getStudente().getCognome();
                    		%>
    	                		<div class="row pb-2 pt-2 exam-row d-flex align-items-center">
    			                    <div class="col-sm-4 ps-3">
    			                     	<%=nomeCompleto%>
    			                    </div>
    			                    <div class="col-sm-2 text-center">
    			                        <%=i.getStudente().getUsername()%>
    			                    </div>
    			                    
    			                    <div class="col-sm-6 text-center">
    			                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modal<%=i.getStudente().getUsername()%>">Leggi</button>
    			                    </div>
    			                </div>
                    		<% 
                		}
                	}
                %>
                <%
                	for(InformazioniCitta i: informazioni){
                		if(i.getStatoConvalida() == StatoConvalida.IN_ATTESA){
                			String nomeCompleto=i.getStudente().getNome()+" "+i.getStudente().getCognome();
                    		%>
    	                		<div class="modal modal-lg fade" id="modal<%=i.getStudente().getUsername()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    				            <div class="modal-dialog">
    				              <div class="modal-content">
    				                <div class="modal-header">
    				                  <h1 class="modal-title fs-5" id="exampleModalLabel">Leggi</h1>
    				                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    				                </div>
    				                <div class="modal-body">
    				                    <h2><%=nomeCompleto %></h2>
    				                    <p>Informazioni inviate</p>
    				
    				                    <div class="container">
    				                        <div class="row">
    				                            <div class="col-sm-8">
    				                                <div class="mb-3">
    				                                  <label for="" class="form-label">Tipo abitazione</label>
    				                                  <input type="text"
    				                                    class="form-control" name="" id="" aria-describedby="helpId" value="<%=i.getTipoAbitazione()%>" readonly>
    				                                    <label for="" class="form-label">Costo Affitto (&euro;)</label>
    				                                  <input type="text"
    				                                    class="form-control" name="" id="" aria-describedby="helpId" value="<%=i.getAffitto() %>" readonly>
    				                                </div>
    				                            </div>
    				                            <div class="col-sm-4"></div>
    				                        </div>
    				                        <div class="row">
    				                            <div class="col-sm-12">
    				                                <label for="" class="form-label">Valutazione dei mezzi</label>
    				                                <span class="field-label-info"></span>
    				                                <input type="hidden" id="selected_rating" name="selected_rating" value="" required="required">
    				                                </label>
    				                                <h2 class="bold rating-header">
    				                                <span class="selected-rating"><%=i.getValutazioneMezzi() %></span><small> / 5</small>
    				                                </h2>
    				                            </div>
    				                        </div>
    				                        <div class="row">
    				                            <div class="col-sm-12">
    				                                <label for="" class="form-label">Valutazione del livello culturale</label>
    				                                <span class="field-label-info"></span>
    				                                <input type="hidden" id="selected_rating" name="selected_rating" value="" required="required">
    				                                </label>
    				                                <h2 class="bold rating-header">
    				                                <span class="selected-rating"><%=i.getLivelloCulturale() %></span><small> / 5</small>
    				                                </h2>
    				                            </div>
    				                        </div>
    				                        <div class="row">
    				                            <div class="col-sm-12">
    				                                <div class="mb-3">
    				                                  <label for="" class="form-label">Recensione Citt&agrave;</label>
    				                                  <textarea class="form-control" name="" id="" rows="3" readonly>
    				                                  	<%=i.getRecensioneCitta() %>
    				                                  </textarea>
    				                                </div>
    				                            </div>
    				                        </div>
    				                        <div class="row">
    				                        	<div class="col-sm-12">
    				                        		<div class="mb-3">
    				                        			<label for="" class="form-label">Lista Luoghi Preferiti</label>
    				                        			<%
    				                        				List<LuogoPreferito> luoghi = i.getListaLuoghiPreferiti();
    				                        				for(LuogoPreferito l: luoghi){
    				                        					%>
    				                        						<p class="text-justify"><%=l.getNomeLuogo()%></p>
    				                        					<%
    				                        				}
    				                        			%>
     				                        		</div>
    				                        	</div>
    				                        </div>
    				                    </div>
    				                    
    				                    <div class="row">
    				                        <div class="col-sm-6 pt-2 pb-2 pe-4 text-justify">
    				                            <button type="button" class="btn btn-success" onClick="convalida('convalida?b=accetta&target=<%=i.getStudente().getUsername()%>')">Convalida</button>
    				                        </div>
    				                        <div class="col-sm-6 pt-2 pb-2 pe-4 text-end">
    				                            <button type="button" class="btn btn-danger" onClick="convalida('convalida?b=rifiuta&target=<%=i.getStudente().getUsername()%>')">Rifiuta</button>
    				                        </div>
    				                    </div>
    				                </div>
    				              </div>
    				            </div>
    				          </div>
                    		<% 	
                		}
                	}
                %>
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

