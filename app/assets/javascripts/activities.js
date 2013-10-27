$(document).ready(function(){
	var $container = $('#activity_stream_wrap');

	$container.imagesLoaded(function(){
	  $container.isotope({
	    masonry: {
		    columnWidth: 320
		  },
		  itemSelector: '.list_act_wrap',
	  });
	});

	
});