$("#esame").on({
    change: () => {
        // Ottieni il valore selezionato dall'elemento select con id "esame"
        const selectedValue = $("#esame").val() - 1;

        // Esegui la richiesta GET al server
        $.ajax({
        url: "registraEsame", // Sostituisci con l'URL corretto del server
        method: "GET",
        data: { id: selectedValue }, // Passa eventuali parametri al server
        dataType: "json", // Imposta il tipo di dati attesi come JSON
        headers: {
            Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
        },
        success: function(response) {
            console.log(response);

            $("#cfu").val(response);
        },
        error: function(xhr, status, error) {
            // Gestisci eventuali errori
            alert("Errore...");
        }
        });
    }
});

$("#register-btn").on({
    click : () => {
        let esame = $("#esame").val() - 1;
        let voto = $("#voto").val();
        let cfu = $("#cfu").val();
        let lode = $("#lode").is(":checked");

        if(esame < 0 || voto == "" || voto < 18 || voto > 30
         || cfu == "" || cfu <= 0) {
            alert("Compilare correttamente tutti i campi prima di proseguire!");
            return;
        } else if(lode == true && voto < 30) {
            alert("La lode può essere inserita solo se il voto è uguale a 30!");
            return;
        }

        $.ajax({
            url: "registraEsame", // Sostituisci con l'URL corretto del server
            method: "POST",
            data: { esame : esame, voto : voto, cfu : cfu, lode : lode }, // Passa eventuali parametri al server
            dataType: "json", // Imposta il tipo di dati attesi come JSON
            headers: {
                Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
            },
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

$("#preview-btn").on({
    click : () => {
        let voto = $("#voto-preview").val();
        let cfu = $("#cfu-preview").val();
        let lode = $("#lode-preview").is(":checked");

        if(voto == "" || voto < 18 || voto > 30 || cfu == "" || cfu <= 0) {
            alert("Compilare correttamente tutti i campi prima di proseguire!");
            return;
        } else if(lode == true && voto < 30) {
            alert("La lode può essere inserita solo se il voto è uguale a 30!");
            return;
        }

        $.ajax({
            url: "proiettaVoto", // Sostituisci con l'URL corretto del server
            method: "POST",
            data: { voto : voto, cfu : cfu, lode : lode }, // Passa eventuali parametri al server
            dataType: "json", // Imposta il tipo di dati attesi come JSON
            headers: {
                Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
            },
            success: function(response) {
                console.log(response);

                $("#proiezione-cfu").text(response.CFU);
                $("#proiezione-media").text(response.media.toFixed(2));
                $("#proiezione-base").text(response.baseDiLaurea.toFixed(2));
                $("#proiezione-modal").modal("show");
            },
            error: function(xhr, status, error) {
                // Gestisci eventuali errori
                alert("Errore...");
            }
        });
    }
})

$(".remove-btn").on({
    click : function(event) {
    let id = event.currentTarget.value;
    $.ajax({
        url: "librettoController", // Sostituisci con l'URL corretto del server
        method: "GET",
        data: { id: id }, // Passa eventuali parametri al server
        dataType: "json", // Imposta il tipo di dati attesi come JSON
        headers: {
            Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
        },
        success: function(response) {
            location.reload();
        },
        error: function(xhr, status, error) {
            alert(error);
        }
    });
    }
})

$(".modify-btn").on({
    click : function(event) {
    let id = event.currentTarget.value;
    let cfu = event.currentTarget.name;

    console.log(id);
    console.log(cfu);
    
    $("#esame-modify").val(cfu);
    $("#cfu-modify").val(id);

    $("#modifyModal").modal("show");
    }
});

$("#save-modify-btn").on({
    click : () => {
        console.log("ok");
        let id = $("#esame-modify").val();
        let voto = $("#voto-modify").val();
        let cfu = $("#cfu-modify").val();
        let lode = $("#lode-modify").is(":checked");

        if(id == "" || voto == "" || voto < 18 || voto > 30 || cfu == "" || cfu <= 0) {
            alert("Compilare correttamente tutti i campi prima di proseguire!");
            return;
        } else if(lode == true && voto < 30) {
            alert("La lode può essere inserita solo se il voto è uguale a 30!");
            return;
        }

        $.ajax({
            url: "librettoController", // Sostituisci con l'URL corretto del server
            method: "POST",
            data: { id : id, voto : voto, cfu : cfu, lode : lode }, // Passa eventuali parametri al server
            dataType: "json", // Imposta il tipo di dati attesi come JSON
            headers: {
                Accept: "application/json" // Imposta l'intestazione "Accept" come "application/json"
            },
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