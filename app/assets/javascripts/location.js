$( document ).ready(function() {
    $( "#exclude_near_by_locations" ).on( "click", function() {
      $('#nearbylocations').removeAttr("style")
      $( "#exclude_near_by_locations").css("text-decoration","underline", "cursor","pointer");  
      var text = $(this).text() == 'Include Nearby Localities' ? 'Exclude Nearby Localities' : 'Exclude Nearby Localities';
      $(this).text(text);
      if (text == "Include Nearby Localities") {
        if ( !($('#search_include_near_by_locations').is(':checked')) ) {
          $('#search_include_near_by_locations').prop('checked', true);   
        }
      }
      else {
        if ( ($('#search_include_near_by_locations').is(':checked')) ) {
          $('#search_include_near_by_locations').prop('checked', false);   
        }
      } 
    });

    $('#nearbylocations').click(function() {
      $( "#exclude_near_by_locations").removeAttr("style")
      $('#nearbylocations').css("text-decoration","underline", "cursor","pointer");
    });

});

