$(document).ready(function(){
	var $container = $('#activity_stream_wrap');

	$container.imagesLoaded(function(){
	  $container.isotope({
	    masonry: {
		    columnWidth: 320
		  },
		  onLayout: function($elems, instance) {
		      // Add exponential z-index for dropdown cropping
		      $elems.each(function(e){
		      $(this).css({ zIndex: ($elems.length - e) });
		    });
		  },
		  itemSelector: '.list_act_wrap',
	  });

		  // bind filter on radio button click
	  $('#stream_filters').on( 'click', 'input', function() {
	    // get filter value from input value
	    var filterValue = this.value;
	    console.log( filterValue );
	    $container.isotope({ filter: filterValue });
	  });
	});

	$container.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '#activity_stream_wrap .list_act_wrap',     // selector for all items you'll retrieve
	    loading: {
	    	selector: '#loading',
	    	finishedMsg: '',
	        img: '/assets/ajax-loader (7).gif',
	        msgText: '',
	      },
	      errorCallback : function () { 
	     	$('.load_arrow').fadeOut(); 
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

	$(".load_arrow").click(function(){
    	$('#activity_stream_wrap').infinitescroll('retrieve');
        	return false;
	});

});