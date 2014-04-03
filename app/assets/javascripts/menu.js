$(document).ready(function(){
	$('.copyme').zclip({
		copy: function(){ 
			var id = $(this).attr('id');
			var copythis = $('#code-'+id).text(); 
			return copythis; 
		}
	});

	$('input:text').focus(function () {
	    $(this).select();
	})

	$('input:text').mouseup(function (e) {
	    e.preventDefault();
	});

	$(".search").keypress(function(event) {
	    if (event.which == 13) {
	        event.preventDefault();
	        $("form").submit();
	    }
	});

});