$(".add-to-favorite-button").on({
    click : function() {
        let course = $(this).val();
        console.log(course);
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
            },
            error: function(xhr, status, error) {
                // Gestisci eventuali errori
                alert("Errore...");
            }
        });
    }
})
