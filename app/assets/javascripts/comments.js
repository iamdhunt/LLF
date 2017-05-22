$(document).ready(function(){
	var $c_count = $('#comment_length');
	var $comment = $('#comment_box');
	var text_max = 280;
	var $container = $('.comments_wrap');
	var $editcm = $('#edit_comment_box');

	$comment.one('focus', function(){
		$c_count.css({ 
			"display": "inline", 
			"opacity": "0" 
		}).animate({ "opacity": "1" }, 1300);
		return false;
	});

	autosize($comment);
	autosize($editcm);

	$('#comment_length').html(text_max);

	$comment.on('keyup keydown', function(){	
		var text_length = $comment.val().length;
		var text_remaining = text_max - text_length;

		$('#comment_length').html(text_remaining);

		if (text_remaining < 0){
			$('#comment_length').css('color', '#e30b0b');
		}else{
			$('#comment_length').css('color', '#898989');
		};

	});

	$container.infinitescroll({
	    navSelector  : '.pagination',    // selector for the paged navigation 
	    nextSelector : '.pagination .next_page a',  // selector for the NEXT link (to page 2)
	    itemSelector : '.comments_wrap .comments',     // selector for all items you'll retrieve
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
    	$('.comments_wrap').infinitescroll('retrieve');
        	return false;
	});

	function EditCMCount(){	
		var edit_length = $editcm.val().length;
		var edit_remaining = text_max - edit_length;

		$('#comment_length').html(edit_remaining);

	};	

	if ($editcm.length) {
	    EditCMCount();
	} 

	$editcm.on('keyup keydown', function(){	
		var com_length = $editcm.val().length;
		var com_remaining = text_max - com_length;

		$('#comment_length').html(com_remaining);

		if (com_remaining < 0){
			$('#comment_length').css('color', '#e30b0b');
		}else{
			$('#comment_length').css('color', '#898989');
		};

	});
	
});
