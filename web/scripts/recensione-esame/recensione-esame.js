$(".show-btn").on({
    click: function() {
        let exam = $(this).val();

        $("#exam-name").text(exam);
        $("#exam").val(exam);

        $.ajax({
            url: "recensioneEsame", // Sostituisci con l'URL corretto del server
            method: "GET",
            data: { exam:exam }, // Passa eventuali parametri al server
            dataType: "json", // Imposta il tipo di dati attesi come JSON
            headers: {
                Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
            },
            contentType: "application/json; charset=utf-8",
            success: function(response) {
                $("#voto").val(response.voto);
                $("#weeks").val(response.weeks);
                $("#hours").val(response.hours);

                console.log(response.rating);
                let selected_value = response.rating;
                $("#selected_rating").val(selected_value);
                $(".selected-rating").empty();
                $(".selected-rating").html(selected_value);
                $("#review").val(response.review);
            },
            error: function(xhr, status, error) {
                // Gestisci eventuali errori
                alert("Errore...");
            }
        });
    }
})