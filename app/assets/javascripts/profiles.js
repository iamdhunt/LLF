$(document).ready(function(){
	var $update = $('#update_box');
	var $buttons = $('#action_wrap');
	var $a = $('#update_att')
	var $b = $('#att_med')
	var $menu = $('#member_menu_wrap');
	var $dropdown = $('.member_menu');
	var text_max = 280;

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
		$dropdown.delay(300).slideDown(300);
  		return false;
	});

	$dropdown.mouseleave(function(){
		$dropdown.stop().delay(300).slideUp(300);
		return false;
	});
});