$(document).ready(function() {
	var $blb = $('.bl_in')
  	var $container = $('#prs2')

	$container.imagesLoaded(function(){
	  $container.isotope({
	    masonry: {
		    columnWidth: 245,
		    isFitWidth: true
		  },
		  onLayout: function($elems, instance) {
		      // Add exponential z-index for dropdown cropping
		      $elems.each(function(e){
		      $(this).css({ zIndex: ($elems.length - e) });
		    });
		  },
		  itemSelector: '.p_list_wrap',
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
	    itemSelector : '#prs2 .p_list_wrap',     // selector for all items you'll retrieve
	    loading: {
	    	selector: '#loading',
	    	finishedMsg: '',
	        img: '/assets/ajax-loader-(6).GIF',
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
    	$('#prs2').infinitescroll('retrieve');
        	return false;
	});

	$('#em_res_wrap a').embedly({key: '85fb5adba4084b5bb7575938182a837f',
	  display: function(obj){
	    // Overwrite the default display.
	    if (obj.type === 'video' || obj.type === 'rich'){
	      // Figure out the percent ratio for the padding. This is (height/width) * 100
	      var ratio = ((obj.height/obj.width)*100).toPrecision(4) + '%'
	 
	      // Wrap the embed in a responsive object div. See the CSS here!
	      var div = $('<div id="proj_video">').css({
	        paddingBottom: ratio
	      });
	 
	      // Add the embed to the div.
	      div.html(obj.html);
	 
	      // Replace the element with the div.
	      $(this).replaceWith(div);
	    }
	  }
	});

});