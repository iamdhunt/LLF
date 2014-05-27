$(document).ready(function(){
	var $update = $('#update_box');
	var $buttons = $('#action_wrap');
	var $a = $('#update_att')
	var $b = $('#att_med')
	var $menu = $('#member_menu_wrap');
	var $dropdown = $('.member_menu');
	var text_max = 280;
	var $container = $('#prof_projs')

	$update.one('focus', function(){
		$(this).autosize();
		$buttons.css({ 
			"display": "block", 
			"opacity": "0" 
		}).animate({ "opacity": "1" }, 1300);
		return false;
	});

	$('#stat_count').html(text_max);

	$update.keyup(function(){	
		var text_length = $update.val().length;
		var text_remaining = text_max - text_length;

		$('#stat_count').html(text_remaining);

		if (text_remaining <= 20){
			$('#stat_count').css('color', '#c72835');
		}else{
			$('#stat_count').css('color', '#898989');
		};
	});	
	
	$b.click(function(){
		$a.toggle("slow", function(){
			
		});
	});
	
	$menu.hover(function(){
		$dropdown.delay(300).slideDown("slow");
  		return false;
	});

	$container.imagesLoaded(function(){
	  $container.isotope({
	    masonry: {
		    columnWidth: 240
		  },
		  onLayout: function($elems, instance) {
		      // Add exponential z-index for dropdown cropping
		      $elems.each(function(e){
		      $(this).css({ zIndex: ($elems.length - e) });
		    });
		  },
		  itemSelector: '#p_list_wrap',
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
	    itemSelector : '#prof_projs #p_list_wrap',     // selector for all items you'll retrieve
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
    	$('#prof_projs').infinitescroll('retrieve');
        	return false;
	});

});