function init_comment () {
    $("#comment_box").keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            $("#comment_form").submit();
        }
    });
}

function init_mcount () {
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
}

function init_ncount () {
    if (notificationCount > 0 && notificationCount < 5) {
        $('#n_alert').attr( "class", "n_alert1" );
    } else if (notificationCount >= 5 && notificationCount < 10) {
        $('#n_alert').attr( "class", "n_alert2" );
    } else if (notificationCount >= 10 && notificationCount < 20) {
        $('#n_alert').attr( "class", "n_alert3" );
    } else if (notificationCount >= 20) {
        $('#n_alert').attr( "class", "n_alert4" );
    } else {
        $('#n_alert').attr( "class", "n_alert4" );
    }
}

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

	$("#update_box").keypress(function(event) {
	    if (event.which == 13) {
	        event.preventDefault();
	        $("#status_form").submit();
	    }
	});

    init_comment();

	$(".modal").on('shown', function() {
        $(this).find("[autofocus]:first").focus();
    });

    init_mcount();

    init_ncount();

    if(isMobile.any()) {
       $( "#discover" ).attr( "placeholder", "Discover people & brands" );
    }

});