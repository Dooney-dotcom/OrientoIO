let result = [];

$("#city").on({
    change : function() {
        let name = $(this).val();
        

        if(name =="") {
            $("#course").prop('disabled', 'disabled');
            $("#university").prop('disabled', 'disabled');
            $("#piano").prop('disabled', 'disabled');
            return;
        }

        $.ajax({
            url: "registrazione", // Sostituisci con l'URL corretto del server
            method: "GET",
            data: { api: "getCity", name: name }, // Passa eventuali parametri al server
            dataType: "json", // Imposta il tipo di dati attesi come JSON
            headers: {
                Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
            },
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                result = response;
               
                $("#university").html("<option value='' disabled selected>Seleziona un'Universit&agrave;</option>");
                response.map(r => {$("#university").append("<option value='" + r.nome + "'>" + r.nome + "</option>")})

                $("#univeristy").prop('disabled', false);
                $("#course").prop('disabled', 'disabled');
                $("#piano").prop('disabled', 'disabled');
            },
            error: function(xhr, status, error) {
                // Gestisci eventuali errori
                alert("Errore...");
            }
        });
    }
})

$("#university").on({
    change : function() {
        let name = $(this).val();

        if(name == "") {
            $("#course").prop('disabled', 'disabled');
            $("#piano").prop('disabled', 'disabled');
            return;
        }

        result.map(univeristy => {
            if(univeristy.nome == name) {
                console.log(univeristy.nome);
                $("#course").html("<option value='' disabled selected>Seleziona un Corso di Laurea</option>");
                univeristy.corsi.map(course => {
                    $("#course").append("<option value='" + course.name + "'>" + course.name + "</option>")
                })
            }
        });

        $("#course").prop('disabled', false);
        $("#piano").prop('disabled', 'disabled');
    }
})

$("#course").on({
    change : function() {
        let name = $(this).val();

        if(name == "") {
            $("#piano").prop('disabled', 'disabled');
            return;
        }

        result.map(r => {
            if(r.nome == $("#university").val()) {
                r.corsi.map(course => {
                    if(course.name == name) {
                        $("#piano").html("<option value='' disabled selected>Seleziona un Piano di Studi</option>");
                        course.piani.map(plan => {$("#piano").append("<option value='" + plan.name + "'>" + plan.name + "</option>")})
                    }
                })
            }
        });

        $("#piano").prop('disabled', false);
    }
})