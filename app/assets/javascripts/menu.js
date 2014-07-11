$(document).ready(function(){
	$('.copyme').zclip({
		copy: function(){ 
			var id = $(this).attr('id');
			var copythis = $('#code-'+id).text(); 
			return copythis; 
		}
	});

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

});