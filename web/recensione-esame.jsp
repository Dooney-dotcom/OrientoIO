<%@page import="java.util.Comparator"%>
<%@page import="model.TipoRestrizione"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="model.TipoCorso"%>
<%@page import="model.Esame"%>
<%@page import="java.util.List"%>
<%@page import="model.EsameSvolto"%>
<%@page import="model.Libretto"%>
<%@page import="model.StudenteUniversitario"%>
<%@page import="model.DatabaseMock"%>
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

// Questa pagina è accessibile a utenti
if(!ruolo.equals("studente")) {
	response.sendRedirect("HomeAmministratore.jsp");
	return;
}

// 5) Check che lo studente non sia bannato
if(ruolo.equals("studente") && 
		((StudenteUniversitario) session.getAttribute("user"))
		.getRestrizione() != null &&
		((StudenteUniversitario) session.getAttribute("user"))
		.getRestrizione().getTipoRestrizione().equals(TipoRestrizione.BAN)){ 
	response.sendRedirect("./login.jsp");
	return;
}

// 6) Per pagine recensione check che lo studente non sia bloccato in scrittura
if(ruolo.equals("studente") && 
		((StudenteUniversitario) session.getAttribute("user"))
		.getRestrizione() != null &&
		((StudenteUniversitario) session.getAttribute("user"))
		.getRestrizione().getTipoRestrizione().equals(TipoRestrizione.SCRITTURA)){ 
	response.sendRedirect("ban.html");
	return;
}

// 7) Prendere lo studente/utente dalla sessione e iniziare a lavorare
StudenteUniversitario s = (StudenteUniversitario) session.getAttribute("user");
List<Esame> esami = s.getPianoFormativo().getEsami();
esami.sort(Comparator.comparingInt(Esame::getAnno)
        .thenComparingInt(Esame::getPeriodo)
        .thenComparingInt(Esame::getCFU)
        .thenComparing(Esame::getNome));
NumberFormat formatter = NumberFormat.getInstance(Locale.ITALY);
formatter.setMaximumFractionDigits(2);
%>
<!doctype html>
<html lang="en">

<head>
  <title>Recensione Esame</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
  integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
  <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">


  <!-- Style -->
  <link rel="stylesheet" href="./styles/recensione-esame.css">

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
  <script src="./scripts/recensione-esame/recensione-esame.js" defer></script>
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

    <main class="py-3">
        <div class="container main-container shadow rounded">
            <div class="row py-4">
                <div class="col-sm-12 text-center">
                    <h3>Ecco la Lista dei tuoi Esami</h3>
                </div>
            </div>
            <div class="container d-flex justify-content-center align-items-center">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr class="text-center">
                                <th scope="col" class="px-5 text-start">Nome Esame</th>
                                <th scope="col" class="px-5">Anno</th>
                                <th scope="col" class="px-5">Periodo</th>
                                <th scope="col" class="px-5">CFU</th>
                                <th scope="col" class="px-5">SSD</th>
                                <th scope="col" class="px-5">Azione</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for(Esame e : esami) { %>
                                <tr>
                                    <td class="text-start" class="px-5"><%= e.getNome() %></td>
                                    <td class="text-center" class="px-5"><%= e.getAnno() %></td>
                                    <td class="text-center" class="px-5"><%= e.getPeriodo() %></td>
                                    <td class="text-center" class="px-5"><%= e.getCFU() %></td>
                                    <td class="text-center" class="px-5"><%= e.getSSO() %></td>
                                    <td class="text-center justify-content-center align-items-center">
                                        <button class="btn btn-success show-btn" data-bs-toggle="modal" data-bs-target="#exampleModal" value="<%=e.getNome()%>">Recensisci</button>
                                    </td>
                                </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="modal modal-lg fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h1 class="modal-title fs-5" id="exampleModalLabel">Recensione</h1>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h2 id="exam-name"></h2>
                    <p>Recensisci questo esame</p>

                    <form class="container" action="recensioneEsame" method="post">
                        <div class="row">
                        	<input name="exam" id="exam" hidden required></input>
                            <div class="col-md-8 mb-3">
                                <label for="voto" class="form-label">Inserisci il voto ottenuto</label>
                                <input type="text" class="form-control" name="voto" id="voto" value="" required>
                                <small id="helpId" class="form-text text-muted">Per 30L scrivi 31.</small>
                            </div>

                            <div class="col-md-4"></div>
                        </div> <!-- End voto input-->

                        <div class="row mb-3">
                            <div class="col-sm-12 col-md-6">
                                <label for="weeks" class="form-label">Quanto tempo hai impiegato per preparare l'esame?</label>
                                <select class="form-select form-select" name="weeks" id="weeks" required>
                                    <option value="0" selected>Settimane</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                </select>
                                <small id="helpId" class="form-text text-muted">Se hai impiegato più di 8 settimane a prepararlo seleziona comunque 8. Racconta di pi&ugrave; nel campo sottostante.</small>
                            </div>
                            <div class="col-sm-12 col-md-6">
                                <div class="mb-3">
                                    <label for="hours" class="form-label">Quante ore al giorno hai studiato per questo esame?</label>
                                    <select class="form-select form-select" name="hours" id="hours" required>
                                        <option value="0" selected>Ore</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                    </select>
                                </div>
                            </div>
                        </div> <!-- End Durata Preparazione -->

                        <div class="row">
                            <div class="col-sm-12">
                                <label for="" class="form-label">Come valuteresti il tuo professore?</label>
                                <span class="field-label-info"></span>

                                <!-- Input hidden dove memorizzare la valutazione -->
                                <input type="hidden" id="selected_rating" name="selected_rating" required="required">

                                <h2 class="bold rating-header">
                                <span id="rating-span" class="selected-rating">0</span><small> / 5</small>
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
                        </div> <!-- End rating professore-->

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="mb-3">
                                <label for="" class="form-label">Dicci di pi&ugrave; su questo esame</label>
                                <textarea class="form-control" name="review" id="review" rows="3" required></textarea>
                                </div>
                            </div>
                        </div> <!-- End recensione-->


                        <div class="row">
                            <div class="col-sm-6 col-md-6 col-lg-6 py-2 pe-4 text-end">
                                <button type="submit" class="btn btn-success">Invia Recensione</button>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-6 py-2 pe-4 text-end">
                                <button type="reset" id="del-btn" class="btn btn-danger">Elimina la Recensione</button>
                            </div>
                        </div>                        
                    </form>
                </div> <!-- End Modal Body-->
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
</body>

</html>