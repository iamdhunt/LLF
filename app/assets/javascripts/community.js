$(document).ready(function(){
	var $scon = $('.community_stream_wrap');
	var $mcon = $('.community_media_wrap');

	$scon.imagesLoaded(function(){
	  $scon.isotope({
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
	  $('#community_stream_filters').on( 'click', 'input', function() {
	    // get filter value from input value
	    var filterValue = this.value;
	    console.log( filterValue );
	    $scon.isotope({ filter: filterValue });
	  });
	});

	$scon.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '.community_stream_wrap .list_act_wrap',     // selector for all items you'll retrieve
	    loading: {
	    	selector: '#p_str_loading',
	    	finishedMsg: '',
	        img: '/assets/ajax-loader (7).gif',
	        msgText: '',
	      },
	      errorCallback : function () { 
	     	$('.p_s_load_arrow').fadeOut(); 
	     }
	    },

	    function( newElements ) {
	      var $newElems = $( newElements ).css({ opacity: 0 });
	      $newElems.imagesLoaded(function(){
	        $newElems.animate({ opacity: 1 });
	        $scon.isotope( 'appended', $newElems, true );
	        soundManager.stopAll();
	        soundManager.reboot();
	      });
	    }
	  );

	$(window).unbind('.infscr');

	$(".p_s_load_arrow").click(function(){
    	$('.community_stream_wrap').infinitescroll('retrieve');
        	return false;
	});

	$mcon.imagesLoaded(function(){
	  $mcon.isotope({
	    masonry: {
		    columnWidth: 192
		  },
		  onLayout: function($elems, instance) {
		      // Add exponential z-index for dropdown cropping
		      $elems.each(function(e){
		      $(this).css({ zIndex: ($elems.length - e) });
		    });
		  },
		  itemSelector: '.list_act_wrap',
	  });
	});

	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        if(e.target.hash == '#media') {
            $mcon.isotope('reLayout');
        }
    });

	  	// bind filter on radio button click
  	$('#community_media_filters').on( 'click', 'input', function() {
	    // get filter value from input value
	    var filterValue = this.value;
	    console.log( filterValue );
	    $mcon.isotope({ filter: filterValue });
  	});
	  
	$mcon.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '.community_media_wrap .list_act_wrap',     // selector for all items you'll retrieve
	    loading: {
	    	selector: '#p_med_loading',
	    	finishedMsg: '',
	        img: '/assets/ajax-loader (7).gif',
	        msgText: '',
	      },
	      errorCallback : function () { 
	     	$('.p_m_load_arrow').fadeOut(); 
	     }
	    },

	    function( newElements ) {
	      var $newElems = $( newElements ).css({ opacity: 0 });
	      $newElems.imagesLoaded(function(){
	        $newElems.animate({ opacity: 1 });
	        $mcon.isotope( 'appended', $newElems, true );
	        soundManager.stopAll();
	        soundManager.reboot();
	      });
	    }
	  );

	$(window).unbind('.infscr');

	$(".p_m_load_arrow").click(function(){
    	$('.community_media_wrap').infinitescroll('retrieve');
        	return false;
	});

});