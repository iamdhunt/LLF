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

	$container.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '#statuses .list_act_wrap',     // selector for all items you'll retrieve
	    loading: {
	    	selector: '#loading',
	    	finishedMsg: '',
	        img: '/assets/ajax-loader (7).gif',
	        msgText: '',
	      },
	     errorCallback : function () { 
	     	$('#load-arrow').fadeOut(); 
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

	$("#load-arrow").click(function(){
    	$('#statuses').infinitescroll('retrieve');
        	return false;
	});

});