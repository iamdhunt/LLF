$(document).ready(function(){
	var $c_count = $('#comment_length');
	var $comment = $('#comment_box');
	var text_max = 280;

	$comment.one('focus', function(){
		$c_count.css({ 
			"display": "block", 
			"opacity": "0" 
		}).animate({ "opacity": "1" }, 1300);
		return false;
	});

	$comment.autosize();

	$('#comment_length').html(text_max);

	$comment.keyup(function(){	
		var text_length = $comment.val().length;
		var text_remaining = text_max - text_length;

		$('#comment_length').html(text_remaining);

		if (text_remaining <= 20){
			$('#comment_length').css('color', '#c72835');
		}else{
			$('#comment_length').css('color', '#898989');
		};
	});	
	
});
