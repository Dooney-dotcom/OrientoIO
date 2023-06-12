<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List" %>

<%
	if(request.getSession().getAttribute("user") == null || request.getSession().getAttribute("ruolo") == null || 
			request.getSession().getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
			return;
	}

	if(request.getSession().getAttribute("ruolo").equals("amministratore")){
		response.sendRedirect("HomeAmministratore.jsp");
		return;
	}

	DatabaseMock db = (DatabaseMock) this.getServletContext().getAttribute("db");
	Map<String, CittaUniversitaria> citta = db.getCitta();
%>

<!doctype html>
<html lang="en">

<head>
  <title>Mappa Citta</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" rel="stylesheet">


  <link rel="stylesheet" href="styles/mappa-citta.css">
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
    <div class="container pt-5 pb-5">
      <div class="row mt-2 mb-2 py-2 text-center">
        <div class="col-sm-12">
          <h2>Ottieni maggiori informazioni sulle Citt&agrave; Universitarie</h2>
        </div>
      </div>
      <div class="row ">
      	<%
      		for(String s: citta.keySet()){
      			%>
      				<div class="col-sm-12 col-md-4 mt-4 mb-2 d-flex justify-content-center align-items-center">
          				<div class="city-card" data-bs-toggle="modal" data-bs-target="#<%=s%>">
              				<h4><%= citta.get(s).getNomeCitta()%></h4>
              				<img src="resources/<%= citta.get(s).getNomeCitta().toLowerCase() %>.jpg" alt="">
          				</div>
       				</div>
      			<%
      		}
      	%>
   	 </div>
    </div>
    <%
    	for(String s: citta.keySet()){
    		List<StudenteUniversitario> studenti = citta.get(s).getStudenti();
    		%>
    			<div class="modal modal-lg fade" id="<%=s%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      				<div class="modal-dialog">
        				<div class="modal-content">
          					<div class="modal-header">
            					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          					</div>
          					<div class="modal-body mx-3">
            					<div class="row pb-2 text-center">
              						<div class="col-sm-8 d-flex justify-content-center align-items-center">
                						<h2><%= citta.get(s).getNomeCitta() %></h2>
              						</div>
              					<div class="col-sm-4">
                					<div class="img-container">
                  						<img class="city-img" src="resources/<%= citta.get(s).getNomeCitta().toLowerCase() %>.jpg" alt="Bologna">
                					</div>
              					</div>
            				</div>
            				<hr>
            				<div class="row ps-2">
              					<div class="col-sm-12">
                					<h4>Media affitti</h4>
                					Ecco la media affitti in questa citt&agrave; per tipologia di stanza.
              					</div>
            				</div>
            				<%
            					Map<String, Float> medie = new HashMap<>();
            					//Calcolo della media affitti
            					float singola=0;
            					int c_singola=0;
            					float doppia=0;
            					int c_doppia=0;
            					float tripla=0;
            					int c_tripla=0;
            					float monolocale=0;
            					int c_monolocale=0;
            					float bilocale=0;
            					int c_bilocale=0;
            					for(StudenteUniversitario stud: studenti){
            						if(stud.getInfoCitta() != null){
            							if(stud.getInfoCitta().getTipoAbitazione().equals("Singola")){
                							c_singola++;
                							singola+=stud.getInfoCitta().getAffitto();
                						}
    									if(stud.getInfoCitta().getTipoAbitazione().equals("Doppia")){
                							c_doppia++;
                							doppia+=stud.getInfoCitta().getAffitto();
                						}
    									if(stud.getInfoCitta().getTipoAbitazione().equals("Tripla")){
    										c_tripla++;
    										tripla+=stud.getInfoCitta().getAffitto();
    									}
    									if(stud.getInfoCitta().getTipoAbitazione().equals("Monolocale")){
    										c_monolocale++;
    										monolocale+=stud.getInfoCitta().getAffitto();
    									}
    									if(stud.getInfoCitta().getTipoAbitazione().equals("Bilocale")){
    										c_bilocale++;
    										bilocale+=stud.getInfoCitta().getAffitto();
    									}

            						}
            					}
            					
            					//Inserimento nella mappa
            					medie.put("Singola", (Float) singola/c_singola);
            					medie.put("Doppia", (Float) doppia/c_doppia);
            					medie.put("Tripla", (Float) tripla/c_tripla);
            					medie.put("Monolocale", (Float) monolocale/c_monolocale);
            					medie.put("Bilocale", (Float) bilocale/c_bilocale);
            					
            					for(String m: medie.keySet()){
            						%>
            							<div class="row ps-2 py-2 ">
              								<div class="col-sm-4 border-bottom"><%= m %></div>
              								<%
              									String media = "-";
              									if(!medie.get(m).isNaN()){
              										media = ""+medie.get(m);
              									}
              								%>
              								<div class="col-sm-4 border-bottom">&euro;<%= media %></div>
              								<div class="col-sm-4"></div>
            							</div>
            						<%
            					}
            				%>
            				<hr>
            				<div class="row ps-2">
              					<div class="col-sm-12">
                					<h4>Valutazione Mezzi di Trasporto</h4>
                					La valutazione &egrave; stata effettuata tenendo conto di puntualit&agrave;, collegamenti, ecc.
              					</div>
            				</div>
							<%
								int mezzi=0;
								int cultura=0;
								int count=0;
								
								for(StudenteUniversitario stud: studenti){
									if(stud.getInfoCitta() != null){
										mezzi+=stud.getInfoCitta().getValutazioneMezzi();
										cultura+=stud.getInfoCitta().getLivelloCulturale();
										count++;	
									}
								}
								
								int val_mezzi=0;
								int val_cultura=0;
								
								if(count != 0){
									val_mezzi=Math.round((mezzi/count));
									val_cultura=Math.round((cultura/count));
								}
								
							
							%>
				            <div class="row ps-4 py-3">
				               <div class="ps-2">
			                        <span><%=val_mezzi%></span><small>/5</small>
			                    </div>
				            </div>
				            <hr>
				            <div class="row ps-2">
				              <div class="col-sm-12">
				                <h4>Valutazione Livello Culturale e Luoghi d'Interesse</h4>
				                La valutazione &egrave; stata effettuata tenendo conto di puntualit&agrave;, collegamenti, ecc.
				              </div>
				            </div>
							<div class="row ps-4 py-3">
				               <div class="ps-2">
			                        <span><%=val_cultura%></span><small>/5</small>
			                    </div>
				            </div>
				            <hr>

				            <h4>Recensioni</h4>
				            Ecco le recensioni degli Studenti Universitari sulle citt&agrave; in cui vivono.
							<%
								Map<String, String> recensioni = new HashMap<>();
				            	for(StudenteUniversitario stud: studenti){
				            		if(stud.getInfoCitta() != null){
				            			recensioni.put(stud.getUsername(), stud.getInfoCitta().getRecensioneCitta());
				            		}
				            	}
				            	
				            	for(String username: recensioni.keySet()){
				            		%>
				            			<div class="container mt-2 review-container border rounded shadow">
							              <div class="row ps-2 pt-3">
							                <div class="col-sm-12">
							                  <h6><%=username%></h6>
							                </div>
							              </div>
							              <div class="row ps-5 pt-2 border-bottom">
							                <div class="col-sm-12">
							                  <p><%=recensioni.get(username)%></p>
							                </div>
							              </div>
							            </div>
				            		<%	
				            	}
							%>
				          </div>
				        </div>
				      </div>
				    </div>
    		<% 
    	}
    %>
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