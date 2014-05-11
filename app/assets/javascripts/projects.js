$(document).ready(function() {
  var $vid = $('.vid_in')
  var $wi = $('.w_in')
  var $ti = $('.t_in')
  var f_src = $('.fav').attr('src')
  var s_src = $('.sh').attr('src')
  var m_src = $('.m').attr('src')
  var $container = $('#prs')
  var $fcon = $('#proj_fol')
  var $mcon = $('#p_m_list_wrap')

  $container.imagesLoaded(function(){
	  $container.isotope({
	  	  itemSelector: '#p_list_wrap',
		  layoutMode : 'fitRows',
		  gutter: 10
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
	    itemSelector : '#prs #p_list_wrap',     // selector for all items you'll retrieve
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
	        img: '/assets/ajax-loader (7).gif',
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
	    itemSelector : '#p_m_list_wrap .list_act_wrap',     // selector for all items you'll retrieve
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
	      });
	    }
	  );

	$(window).unbind('.infscr');

	$(".p_m_load_arrow").click(function(){
    	$('#p_m_list_wrap').infinitescroll('retrieve');
        	return false;
	});

  $vid.autosize();
  $wi.autosize();
  $ti.autosize();

  $('.fav').mouseenter(function(){
	        $('.fav').attr('src','/assets/Favorite.png');
	    }
	);
  $('.fav').mouseleave(function(){
	        $('.fav').attr('src', f_src);
	    }
	);

  $('.sh').mouseenter(function(){
	        $('.sh').attr('src','/assets/Share 2.png');
	    }
	);
  $('.sh').mouseleave(function(){
	        $('.sh').attr('src', s_src);
	    }
	);

  $('.m').mouseenter(function(){
	        $('.m').attr('src','/assets/More 3.png');
	    }
	);
  $('.m').mouseleave(function(){
	        $('.m').attr('src', m_src);
	    }
	);

});