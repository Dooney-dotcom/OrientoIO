
let result1 = [];
let result2 = [];

$("#university1").on({
    change : function() {
        let name = $(this).val();

        if(name == "") {
            $("#course1").prop('disabled', 'disabled');
            $("#Piano1").prop('disabled', 'disabled');
            return;
        }

        $.ajax({
            url: "confronto", // Sostituisci con l'URL corretto del server
            method: "GET",
            data: { api: "university", name: name }, // Passa eventuali parametri al server
            dataType: "json", // Imposta il tipo di dati attesi come JSON
            headers: {
                Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
            },
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                result1 = response;

                $("#course1").html("<option value='' disabled selected>Seleziona un Corso di Laurea</option>");
                response.map(course => {$("#course1").append("<option value='" + course.name + "'>" + course.name + "</option>")})

                $("#course1").prop('disabled', false);
                $("#Piano1").prop('disabled', 'disabled');
            },
            error: function(xhr, status, error) {
                // Gestisci eventuali errori
                alert("Errore...");
            }
        });
    }
})

$("#university2").on({
    change : function() {
        let name = $(this).val();

        if(name == "") {
            $("#course2").prop('disabled', 'disabled');
            $("#Piano2").prop('disabled', 'disabled');
            return;
        }

        $.ajax({
            url: "confronto", // Sostituisci con l'URL corretto del server
            method: "GET",
            data: { api: "university", name: name }, // Passa eventuali parametri al server
            dataType: "json", // Imposta il tipo di dati attesi come JSON
            headers: {
                Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
            },
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                result1 = response;

                $("#course2").html("<option value='' disabled selected>Seleziona un Corso di Laurea</option>");

                response.map(course => {$("#course2").append("<option value='" + course.name + "'>" + course.name + "</option>")})

                $("#course2").prop('disabled', false);
                $("#Piano2").prop('disabled', 'disabled');
            },
            error: function(xhr, status, error) {
                // Gestisci eventuali errori
                alert("Errore...");
            }
        });
    }
})


$("#course1").on({
    change : function() {
        let name = $(this).val();
        if(name =="") {
            $("#Piano1").prop('disabled', 'disabled');
            return;
        }

        $("#Piano1").html("<option value='' disabled selected>Seleziona un Piano Formativo</option>");

        result1.map(corso => {
            if(corso.name == name) {
                corso.piani.map(piano => {
                    $("#Piano1").append("<option value='" + piano.name + "'>" + piano.name + "</option>");
                })
            }
        })

        $("#Piano1").prop('disabled', false);
    }
})

$("#course2").on({
    change : function() {
        let name = $(this).val();
        if(name =="") {
            $("#Piano2").prop('disabled', 'disabled');
            return;
        }

        $("#Piano2").html("<option value='' disabled selected>Seleziona un Piano Formativo</option>");

        result1.map(corso => {
            if(corso.name == name) {
                corso.piani.map(piano => {
                    $("#Piano2").append("<option value='" + piano.name + "'>" + piano.name + "</option>");
                })
            }
        })

        $("#Piano2").prop('disabled', false);
    }
})

$("#Piano1").on({
    change : function() {
        let name = $(this).val();

        if(name =="") {
            return;
        }

        if($("#university1").val() == $("#university2").val() &&
        $("#course1").val() == $("#course2").val() &&
        $("#Piano1").val() == $("#Piano1").val()
        ) {
            alert("Scegli due piani formativi diversi per il confronto!");
            return;
        }

        $("#result-list-1").html("");
        result1.map(corso => {
            if(corso.name = name) {
                corso.piani.map(piano => {
                    if(piano.name == name) {
                        piano.esami.map(esame => {
                            console.log(esame);
                            
                            $("#result-list-1").append("<li><a href=''>" + esame.nome + "</a></br>" + 
                            "<span><strong>SSD:&nbsp;</strong>" +  esame.SSD + "</span>&emsp;" + 
                            "<span><strong>CFU:&nbsp;</strong>" +  esame.CFU + "</span> </br>" + 
                            "<span><strong>Periodo:&nbsp;</strong>" +  esame.periodo + "</span>&emsp;" + 
                            "<span><strong>Anno:&nbsp;</strong>" +  esame.anno + "</span></li>");
                        })
                    }
                })
            }
        })
    }
})

$("#Piano2").on({
    change : function() {
        let name = $(this).val();

        if(name =="") {
            return;
        }

        if($("#university1").val() == $("#university2").val() &&
        $("#course1").val() == $("#course2").val() &&
        $("#Piano1").val() == $("#Piano1").val()
        ) {
            alert("Scegli due piani formativi diversi per il confronto!");
            return;
        }

        $("#result-list-2").html("");
        result1.map(corso => {
            if(corso.name = name) {
                corso.piani.map(piano => {
                    if(piano.name = name) {
                        piano.esami.map(esame => {
                            
                            $("#result-list-2").append("<li><a href=''>" + esame.nome + "</a></br>" + 
                            "<span><strong>SSD:&nbsp;</strong>" +  esame.SSD + "</span>&emsp;" + 
                            "<span><strong>CFU&nbsp;:</strong>" +  esame.CFU + "</span> </br>" + 
                            "<span><strong>Periodo:&nbsp;</strong>" +  esame.periodo + "</span>&emsp;" + 
                            "<span><strong>Anno:&nbsp;</strong>" +  esame.anno + "</span></li>");
                        })
                    }
                })
            }
        })
    }
})
