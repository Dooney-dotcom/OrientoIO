$(document).ready(
    function($){

    $(".btnrating-mezzi").on('click',(function(e) {
    
    var previous_value = $("#selected_rating_mezzi").val();
    
    var selected_value = $(this).attr("data-attr");
    $("#selected_rating_mezzi").val(selected_value);
    
    $(".selected-rating-mezzi").empty();
    $(".selected-rating-mezzi").html(selected_value);
    
    for (i = 1; i <= selected_value; ++i) {
    $("#rating-star-mezzi"+i).toggleClass('star-selected');
    $("#rating-star-mezzi"+i).toggleClass('star-default');
    }
    
    for (ix = 1; ix <= previous_value; ++ix) {
    $("#rating-star-mezzi"+ix).toggleClass('star-selected');
    $("#rating-star-mezzi"+ix).toggleClass('star-default');
    }
    
    }));
    
});

$(document).ready(function($){

    $(".btnrating-cultura").on('click',(function(e) {
    
    var previous_value2 = $("#selected_rating_cultura").val();
    
    var selected_value2 = $(this).attr("data-attr");
    $("#selected_rating_cultura").val(selected_value2);
    
    $(".selected-rating-cultura").empty();
    $(".selected-rating-cultura").html(selected_value2);
    
    for (i = 1; i <= selected_value2; ++i) {
    $("#rating-star-cultura-"+i).toggleClass('star-selected');
    $("#rating-star-cultura-"+i).toggleClass('star-default');
    }
    
    for (ix = 1; ix <= previous_value2; ++ix) {
    $("#rating-star-cultura-"+ix).toggleClass('star-selected');
    $("#rating-star-cultura-"+ix).toggleClass('star-default');
    }
    
    }));
    
});