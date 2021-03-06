$(document).ready(function() {
	var $ai = $('.auto')
	var $container = $('#lstgs')
	var $mkcon = $('#llf_lstgs')
	var $mkcon2 = $('#pop_lstgs')
   
	autosize($ai);

	$container.imagesLoaded(function(){
	  $container.isotope({
	  	masonry: {
		    columnWidth: 122,
		    isFitWidth: true
		  },
		  onLayout: function($elems, instance) {
		      // Add exponential z-index for dropdown cropping
		      $elems.each(function(e){
		      $(this).css({ zIndex: ($elems.length - e) });
		    });
		  },
		  itemSelector: '.pdl_wrap',
	  });

	   	// bind filter on radio button click
		$('#listings_filters').on( 'click', 'input', function() {
		    // get filter value from input value
		    var filterValue = this.value;
		    console.log( filterValue );
		    $container.isotope({ filter: filterValue });
	  	});
	});

	$container.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '#lstgs .pdl_wrap',     // selector for all items you'll retrieve
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
	        basicMP3Player.init();
	      });
	    }
	  );

	$(window).unbind('.infscr');

	$(".load_arrow").click(function(){
    	$('#lstgs').infinitescroll('retrieve');
        	return false;
	});

	$mkcon.imagesLoaded(function(){
	  $mkcon.isotope({
	   	masonry: {
		    columnWidth: 122,
		    isFitWidth: true
		  },
		  onLayout: function($elems, instance) {
		      // Add exponential z-index for dropdown cropping
		      $elems.each(function(e){
		      $(this).css({ zIndex: ($elems.length - e) });
		    });
		  },
		  itemSelector: '.pdl_wrap',
	  });

	});

	$mkcon2.imagesLoaded(function(){
	  $mkcon2.isotope({
	   	masonry: {
		    columnWidth: 122,
		    isFitWidth: true
		  },
		  onLayout: function($elems, instance) {
		      // Add exponential z-index for dropdown cropping
		      $elems.each(function(e){
		      $(this).css({ zIndex: ($elems.length - e) });
		    });
		  },
		  itemSelector: '.pdl_wrap',
	  });

	});

	

});