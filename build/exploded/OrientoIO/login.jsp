<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.*" %>

<%
if(this.getServletContext().getAttribute("db") == null) {
	DatabaseMock database = new DatabaseMock();
	this.getServletContext().setAttribute("db", database);
}
%>


<!DOCTYPE html>
<html lang="en">
<head>
  <title>Homepage</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS v5.2.1 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">

    <link rel="stylesheet" href="styles/home.css">
    
    <script>
    
    </script>
</head>

<body>
  <header>
    <div class="container-fluid">
        <div class="row pt-0 pb-0 shadow">
            <div class="col-md-4 col-sm-12 logo-container pt-0 pb-0 mt-0 mb-0">
                <img class="header-logo" src="./resources/logo-footer.png" alt="logo" width="30%">
            </div>
            <div class="col-md-8 col-sm-12 pt-0 mt-0 pb-0 mb-0 pe-5 text-end">
                <span class="home-title h1">OrientoIO</span>
            </div>
        </div>
    </div>
  </header>
  <main>
    <div class="container-fluid">
        <div class="row main-row">
            <div class="col-sm-12 col-md-8 pt-0 ps-0">
            </div>
            <div class="col-md-4 col-sm-12 text-center mt-4">
                <!--p><input type="text" id="username" name="username" placeholder="Username"></p>
                <p><input type="password" id="password" name="password" placeholder="Password"></p>
                <button onClick=''>Login</button> 
                <p>Non ti sei ancora registrato? <a href="registrazione.html">Registrati</a></p -->
                    <form action="autenticazione" method="post" class="py-4 px-4 rounded" id="login">
                        <!-- Email input -->
                        <h2 class="text-center pt-2 mb-4">Benvenuto su OrientoIO!</h2>

                        <hr>

                        <div class="form-outline mt-2 mb-2 pb-2">
                          <input type="text" id="username" name="username" class="form-control" placeholder="Username" />
                        </div>
                      
                        <!-- Password input -->
                        <div class="form-outline mb-4">
                          <input type="password" id="password" name="password" class="form-control" placeholder="Password"/>
                        </div>
                      
                        <!-- 2 column grid layout for inline styling -->
                        <div class="row mb-4">
                          <div class="col d-flex">
                            <!-- Checkbox -->
                            <div class="form-check">
                              <input class="form-check-input" type="checkbox" value="" id="remember" checked />
                              <label class="form-check-label" for="remember">Ricordami</label>
                            </div>
                          </div>
                        </div>
                      
                        <!-- Submit button -->
                        <button type="submit" class="btn btn-primary mb-2 login-btn"><b>Login</b></button>
                      
                        <!-- Register buttons -->
                        <hr>
                        <h6>Non sei ancora registrato?</h6>
                        <a href="./registrazione.html" type="button" class="btn btn-outline-primary registration-btn"><b>Registrati</b></a>
                      </form>
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