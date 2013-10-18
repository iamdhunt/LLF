$(document).ready(function(){
	var $container = $('#media_list_wrap');
	var cap_max = 280;
	var $cap = $('#cap_box')

	$container.imagesLoaded(function(){
	  $container.isotope({
	    masonry: {
		    columnWidth: 192
		  },
		  itemSelector: '.list_act_wrap',
	  });
	});

	$container.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '#media_list_wrap .list_act_wrap',     // selector for all items you'll retrieve
	    loading: {
	    	finishedMsg: '',
	        img: 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==',
	        msgText: ''
	      }
	    },

	    function( newElements ) {
	      var $newElems = $( newElements ).css({ opacity: 0 });
	      $newElems.imagesLoaded(function(){
	        $newElems.animate({ opacity: 1 });
	        $container.isotope( 'appended', $newElems, true ); 
	      });
	    }
	  );

	$(window).unbind('.infscr');

		$("#load_arrow").click(function(){
			$(".load_arrow").attr('src',"/assets/ajax-loader (7).gif").delay(800);
	    	$('#media_list_wrap').infinitescroll('retrieve');
	        	return false;
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