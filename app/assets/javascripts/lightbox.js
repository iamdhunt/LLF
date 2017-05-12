$(document).ready(function() {

  $('[data-fancybox="gallery"]').on('click', function() {
	  var visibleLinks = $('[data-fancybox="gallery"]:visible');

	  $.fancybox.open( visibleLinks, {}, visibleLinks.index( this ) );

	  return false;
	});

});
