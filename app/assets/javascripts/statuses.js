$(document).ready(function(){
	var $container = $('#statuses');

	$container.imagesLoaded(function(){
	  $container.isotope({
	    masonry: {
		    columnWidth: 320
		  },
		  itemSelector: '.list_act_wrap',
	  });
	});

});