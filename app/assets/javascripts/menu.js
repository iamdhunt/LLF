$(document).ready(function(){
	$('#search').focus(function () {
	    $(this).select();
	})

	$('#search').mouseup(function (e) {
	    e.preventDefault();
	});

	$(".search").keypress(function(event) {
	    if (event.which == 13) {
	        event.preventDefault();
	        $("form").submit();
	    }
	});

	$(".modal").on('shown', function() {
        $(this).find("[autofocus]:first").focus();
    });

    if (messageCount > 0 && messageCount < 2) {
    	$('#m_alert').attr( "class", "m_alert1" );
    } else if (messageCount >= 2 && messageCount < 5) {
    	$('#m_alert').attr( "class", "m_alert2" );
    } else if (messageCount >= 5 && messageCount < 10) {
    	$('#m_alert').attr( "class", "m_alert3" );
    } else if (messageCount >= 10) {
    	$('#m_alert').attr( "class", "m_alert4" );
    } else {
    	$('#m_alert').attr( "class", "m_alert4" );
    }

});