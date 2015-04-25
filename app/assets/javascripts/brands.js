$(document).ready(function(){	
	var $di = $('.ds_in')
	var max_nam = 40;
  	var $container = $('#b_index')
  	var $nam = $('#b_cap_nam')
  	var dom = document.getElementById('b_cap_nam')

	$('.b_ct_nam').html(max_nam);

	$nam.keyup(function(){	
		var cap_length = $nam.val().length;
		var cap_remaining = max_nam - cap_length;

		$('.b_ct_nam').html(cap_remaining);

	});

	if(dom != null) {
		var nam_length = $nam.val().length;
		var nam_remaining = max_nam - nam_length;
		$('.b_ct_nam').html(nam_remaining);

		if (nam_remaining <= 10){
			$('.b_ct_nam').css('color', '#c72835');
		}else{
			$('.b_ct_nam').css('color', '#444');
		};

		$nam.keyup(function(){	
			var nam_length = $nam.val().length;
			var nam_remaining = max_nam - nam_length;

			$('.b_ct_nam').html(nam_remaining);

			if (nam_remaining <= 10){
				$('.b_ct_nam').css('color', '#c72835');
			}else{
				$('.b_ct_nam').css('color', '#8930c7');
			};
		});
	};

	$di.autosize();

	$container.imagesLoaded(function(){
	  $container.isotope({
	    masonry: {
		    columnWidth: 312
		  },
		  onLayout: function($elems, instance) {
		      // Add exponential z-index for dropdown cropping
		      $elems.each(function(e){
		      $(this).css({ zIndex: ($elems.length - e) });
		    });
		  },
		  itemSelector: '#bi_wrap',
	  });
	});

	$container.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '#b_index #bi_wrap',     // selector for all items you'll retrieve
	    loading: {
	    	selector: '#loading',
	    	finishedMsg: '',
	        img: '/assets//assets/ajax-loader-(6).GIF',
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
    	$('#b_index').infinitescroll('retrieve');
        	return false;
	});

});