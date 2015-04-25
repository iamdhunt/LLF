$(document).ready(function() {
  var $vid = $('.vid_in')
  var $wi = $('.w_in')
  var $ti = $('.t_in')
  var $blb = $('.bl_in')
  var $cty = $('.p_city')
  var f_src = $('.fav').attr('src')
  var s_src = $('.sh').attr('src')
  var m_src = $('.m').attr('src')
  var $container = $('#prs')
  var $fcon = $('#proj_fol')
  var $mcon = $('.p_m_list_wrap')
  var $ucon = $('.u_list_wrap')
  var cap_max_blb = 140;
  var $cap_blb = $('#p_cap_blb')
  var dom = document.getElementById('p_cap_blb');

  $container.imagesLoaded(function(){
	  $container.isotope({
	    masonry: {
		    columnWidth: 245
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
	    itemSelector : '#prs .p_list_wrap',     // selector for all items you'll retrieve
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
    	$('#prs').infinitescroll('retrieve');
        	return false;
	});

	$fcon.imagesLoaded(function(){
	  $fcon.isotope({
		  itemSelector: '#follow_item_wrap',
		  layoutMode : 'fitRows',
		  gutter: 10
	  });
	});

	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        if(e.target.hash == '#followers') {
            $fcon.isotope('reLayout');
        }
    });

	$fcon.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '#proj_fol #follow_item_wrap',     // selector for all items you'll retrieve
	    loading: {
	    	selector: '#p_fol_loading',
	    	finishedMsg: '',
	        img: '/assets/ajax-loader-(6).GIF',
	        msgText: '',
	      },
	      errorCallback : function () { 
	     	$('.p_f_load_arrow').fadeOut(); 
	     }
	    },

	    function( newElements ) {
	      var $newElems = $( newElements ).css({ opacity: 0 });
	      $newElems.imagesLoaded(function(){
	        $newElems.animate({ opacity: 1 });
	        $fcon.isotope( 'appended', $newElems, true ); 
	      });
	    }
	  );

	$(window).unbind('.infscr');

	$(".p_f_load_arrow").click(function(){
    	$('#proj_fol').infinitescroll('retrieve');
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
	  
	$mcon.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '.p_m_list_wrap .list_act_wrap',     // selector for all items you'll retrieve
	    loading: {
	    	selector: '#p_med_loading',
	    	finishedMsg: '',
	        img: '/assets/ajax-loader-(6).GIF',
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
    	$('.p_m_list_wrap').infinitescroll('retrieve');
        	return false;
	});
	  
	$ucon.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '.u_list_wrap .update_wrap',     // selector for all items you'll retrieve
	    loading: {
	    	selector: '#p_upd_loading',
	    	finishedMsg: '',
	        img: '/assets/ajax-loader-(6).GIF',
	        msgText: '',
	      },
	      errorCallback : function () { 
	     	$('.p_u_load_arrow').fadeOut(); 
	     }
	    },

	    function( newElements ) {
	      var $newElems = $( newElements ).css({ opacity: 0 });
	      $newElems.imagesLoaded(function(){
	        $newElems.animate({ opacity: 1 });
	        $ucon.isotope( 'appended', $newElems, true ); 
	      });
	    }
	  );

	$(window).unbind('.infscr');

	$(".p_u_load_arrow").click(function(){
    	$('.u_list_wrap').infinitescroll('retrieve');
        	return false;
	});

	if(dom != null) {
		var cap_length = $cap_blb.val().length;
		var cap_remaining = cap_max_blb - cap_length;
		$('.p_ct_blb').html(cap_remaining);

		$cap_blb.keyup(function(){	
			var cap_length = $cap_blb.val().length;
			var cap_remaining = cap_max_blb - cap_length;

			$('.p_ct_blb').html(cap_remaining);

		});
	};

  $vid.autosize();
  $wi.autosize();
  $ti.autosize();
  $blb.autosize();
  $cty.autosize();

});