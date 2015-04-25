$(document).ready(function(){
	var $container = $('#media_list_wrap');
	var $cfav = $('#m_fav_list_wrap')
	var cap_max = 280;
	var $cap = $('#cap_box')
	var dl_src = $('.dl').attr('src')

	$cap.autosize();

	$container.imagesLoaded(function(){
	  $container.isotope({
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

		  // bind filter on radio button click
	  $('#stream_filters').on( 'click', 'input', function() {
	    // get filter value from input value
	    var filterValue = this.value;
	    console.log( filterValue );
	    $container.isotope({ filter: filterValue });
	  });
	  
	$container.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '#media_list_wrap .list_act_wrap',     // selector for all items you'll retrieve
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
	        soundManager.stopAll();
	        soundManager.reboot(); 
	      });
	    }
	  );

	$(window).unbind('.infscr');

	$(".load_arrow").click(function(){
    	$('#media_list_wrap').infinitescroll('retrieve');
        	return false;
	});

	$cfav.imagesLoaded(function(){
	  $cfav.isotope({
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

		  // bind filter on radio button click
	  $('#stream_filters').on( 'click', 'input', function() {
	    // get filter value from input value
	    var filterValue = this.value;
	    console.log( filterValue );
	    $cfav.isotope({ filter: filterValue });
	  });
	  
	$cfav.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '#m_fav_list_wrap .list_act_wrap',     // selector for all items you'll retrieve
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
	        $cfav.isotope( 'appended', $newElems, true );
	        soundManager.stopAll();
	        soundManager.reboot(); 
	      });
	    }
	  );

	$(window).unbind('.infscr');

	$(".load_arrow").click(function(){
    	$('#m_fav_list_wrap').infinitescroll('retrieve');
        	return false;
	});

	$('#cap_count').html(cap_max);

	$cap.keyup(function(){	
		var cap_length = $cap.val().length;
		var cap_remaining = cap_max - cap_length;

		$('#cap_count').html(cap_remaining);

	});

	$(".fancybox").fancybox({
        padding     : 0,
		minHeight: 400,
		beforeShow: function(){
		   	this.title = $("#fancyboxTitles div").eq(this.index).html();
		},
		helpers: {
		   title : {
		    type : 'outside'
		   }
		},
		afterShow: function() {
	        var imageWidth = $(".fancybox-image").width();
	        $(".fancybox-title-outside-wrap").css({
	            "width": imageWidth,
	            "paddingLeft": '10px',
	            "paddingRight": '10px',
	            "textAlign": "center"
	        });
	    }
	});

	$('.dl').mouseenter(function(){
	        $('.dl').attr('src','/assets/Trash 3.png');
	    }
	);
  	$('.dl').mouseleave(function(){
	        $('.dl').attr('src', dl_src);
	    }
	);

});