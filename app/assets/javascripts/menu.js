$(document).ready(function(){
	$('.copyme').zclip({
		copy: function(){ 
			var id = $(this).attr('id');
			var copythis = $('#code-'+id).text(); 
			return copythis; 
		}
	});
});