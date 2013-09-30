$(document).ready(function(){
var $container = $('#media_list_wrap');

	$container.imagesLoaded( function(){
	  $container.isotope({
	    masonry: {
		    columnWidth: 192
		  },
		  itemSelector: '.media',
	  });
	});
});