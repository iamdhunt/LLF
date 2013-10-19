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
	    	selector: '#loading',
	    	finishedMsg: '',
	        img: '/assets/ajax-loader (7).gif',
	        msgText: ''
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