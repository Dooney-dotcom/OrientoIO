$(".show-btn").on({
    click: function() {
        let exam = $(this).val();

        $("#exam-name").text(exam);
        $("#exam").val(exam);

        $.ajax({
            url: "recensioneEsame", // Sostituisci con l'URL corretto del server
            method: "GET",
            data: { api: "search", exam:exam }, // Passa eventuali parametri al server
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
                $(".selected_rating").empty();
                $(".selected_rating").text(selected_value);

                $("#rating-span").text(selected_value);
                $("#review").val(response.review);
            },
            error: function(xhr, status, error) {
                // Gestisci eventuali errori
                alert("Errore...");
            }
        });
    }
})

$(document).ready(function($){
            
    $(".btnrating").on('click',(function(e) {
    
    var previous_value = $("#selected_rating").val();
    
    var selected_value = $(this).attr("data-attr");
    $("#selected_rating").val(selected_value);
    
    $("#rating-span").text(selected_value);
    
    for (i = 1; i <= selected_value; ++i) {
    $("#rating-star-"+i).toggleClass('star-selected');
    $("#rating-star-"+i).toggleClass('star-default');
    }
    
    for (ix = 1; ix <= previous_value; ++ix) {
    $("#rating-star-"+ix).toggleClass('star-selected');
    $("#rating-star-"+ix).toggleClass('star-default');
    }
    
    })); 
});

$(".btnrating").on({
    click : function() {
        let previous_value = $("#selected_rating").val();
        let selected_value = $(this).attr("data-attr");

        $("#selected_rating").val(selected_value);
        $(".selected-rating").empty();
        $(".selected-rating").html(selected_value);
        
        for (i = 1; i <= selected_value; ++i) {
        $("#rating-star-"+i).toggleClass('star-selected');
        $("#rating-star-"+i).toggleClass('star-default');
        }
        
        for (ix = 1; ix <= previous_value; ++ix) {
        $("#rating-star-"+ix).toggleClass('star-selected');
        $("#rating-star-"+ix).toggleClass('star-default');
        }
    }
})

$("#del-btn").on({
    click: function() {
        let exam = $("#exam").val();

        if(exam == null || exam == undefined) {
            return;
        }

        $.ajax({
            url: "recensioneEsame", // Sostituisci con l'URL corretto del server
            method: "GET",
            data: { api: "delete", exam:exam }, // Passa eventuali parametri al server
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