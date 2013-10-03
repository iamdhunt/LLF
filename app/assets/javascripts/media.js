$(document).ready(function(){
	var $container = $('#media_list_wrap');
	var cap_max = 280;
	var $cap = $('#cap_box')

	$container.imagesLoaded(function(){
	  $container.isotope({
	    masonry: {
		    columnWidth: 192
		  },
		  itemSelector: '.media',
	  });
	});

	$('#cap_count').html(cap_max);

	$cap.keyup(function(){	
		var cap_length = $cap.val().length;
		var cap_remaining = cap_max - cap_length;

		$('#cap_count').html(cap_remaining);

		if (cap_remaining <= 20){
			$('#cap_count').css('color', '#c72835');
		}else{
			$('#cap_count').css('color', '#8930c7');
		};
	});

});