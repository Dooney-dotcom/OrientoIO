$("#add-btn").on({
    click : () => {
        let name = $("#search-corso").val();

        $("#search-results").html();

        $.ajax({
            url: "listaPreferiti", // Sostituisci con l'URL corretto del server
            method: "GET",
            data: { api: "search", name: name }, // Passa eventuali parametri al server
            dataType: "json", // Imposta il tipo di dati attesi come JSON
            headers: {
                Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
            },
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                console.log(response)

                $("#search-results").append("<ul id='result-list' class='list-group'></ul>");
                response.map(course => {
                    let info = course.split("____");
                    $("#result-list").append("<li class='list-group-item' data-course='" + course + "'>" + info[0] + "&nbsp;-&nbsp;" + info[1] + "<br>" + info[2].replace("_", " ") + "</li>");
                })

                $("#search-results").on("click", ".list-group-item", function() {
                    let course = $(this).data("course");
                    
                    $.ajax({
                        url: "listaPreferiti", // Sostituisci con l'URL corretto del server
                        method: "GET",
                        data: { api: "add", name: course }, // Passa eventuali parametri al server
                        dataType: "json", // Imposta il tipo di dati attesi come JSON
                        headers: {
                            Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
                        },
                        contentType: "application/json; charset=utf-8",
                        success: function(response) {
                            alert(response);
                            location.reload();
                        },
                        error: function(xhr, status, error) {
                            // Gestisci eventuali errori
                            alert("Errore...");
                        }
                    });
                });
                
            },
            error: function(xhr, status, error) {
                // Gestisci eventuali errori
                alert("Errore...");
            }
        });
    }
})

$(".del-btn").on({
    click: function() {

        let course = $(this).val();
        $.ajax({
            url: "listaPreferiti", // Sostituisci con l'URL corretto del server
            method: "GET",
            data: { api: "remove", name: course }, // Passa eventuali parametri al server
            dataType: "json", // Imposta il tipo di dati attesi come JSON
            headers: {
                Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
            },
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                alert(response);
                location.reload();
            },
            error: function(xhr, status, error) {
                // Gestisci eventuali errori
                alert("Errore...");
            }
        });
    }
})