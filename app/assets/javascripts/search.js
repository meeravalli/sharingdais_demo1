$(document).ready(function(){
    $("input:radio[name^=search]").click(function() {
        $("#search_no_of_persons").show();
        $("#search_any").show();
        $("#any").show();
        $("#search_meal_type_id").show();
        $("#search_region_id").show();
        $("#meal").html("Meal")
        $("#region").show();
        $("#search_identity").hide();
        $("#search_no_of_guests").hide();
        $("#guests").hide();
        $("#search_any1").hide();
        $("#any1").hide();
        $("#search_no_of_persons").attr('disabled', false);
        $("#search_any").attr('checked', false);
        if ($("#search_food_0").is(":checked")) {            
            $("#label_text").html("I am looking for food (No.of.People)");
        } else if ($("#search_food_1").is(":checked")) {
            $("#label_text").html( "I am looking to provide food for (No.of.People)" );
        }
        else{
            $("#search_no_of_guests").attr('disabled', false);
            $("#search_any1").attr('checked', false);
            reload_bulk();
        }
    })

    $("input:checkbox[name^=search]").click(function() {
        if ($("#search_any").is(":checked")) {
            $("#search_no_of_persons").attr('disabled', true);
            $("#search_no_of_persons").val('');
        }
        else {
            $("#search_no_of_persons").attr('disabled', false);
        }
        if ($("#search_any1").is(":checked")) {
            $("#search_no_of_guests").attr('disabled', true);
            $("#search_no_of_guests").val('');
        }
        else {
            $("#search_no_of_guests").attr('disabled', false);
        }
    })
    
  
    function isInteger(n) {
        return /^[0-9]+$/.test(n);
    }
    
    function reload_bulk(){
        $("#label_text").html("I'm");
        $("#people").hide();
        $("#search_no_of_persons").hide();
        $("#search_any").hide();
        $("#any").hide();
        $("#search_meal_type_id").hide();
        $("#search_region_id").hide();
        $("#meal").html( "No.of.Guests" );
        $("#region").hide();
        $("#search_identity").show();
        $("#search_no_of_guests").show();
        $("#guests").show();
        $("#search_any1").show();
        $("#any1").show();
    }    
});

