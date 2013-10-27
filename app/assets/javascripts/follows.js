$(document).ready(function(){
	var $container = $('#follow_list_wrap');

	$container.imagesLoaded(function(){
	  $container.isotope({
		  itemSelector: '#follow_item_wrap',
		  layoutMode : 'fitRows',
		  gutter: 10
	  });
	});

});