function init_comment () {
    $("#comment_box").keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            $("#comment_form").submit();
        }
    });
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