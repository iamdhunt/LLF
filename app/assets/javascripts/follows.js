$(document).ready(function(){
	var $container = $('#follow_list_wrap');

	$container.imagesLoaded(function(){
	  $container.isotope({
		  itemSelector: '.follow_item_wrap',
		  layoutMode : 'fitRows',
		  gutter: 10
	  });
	});

	$container.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '#follow_list_wrap .follow_item_wrap',     // selector for all items you'll retrieve
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
	    	$('#follow_list_wrap').infinitescroll('retrieve');
	        	return false;
	});

});