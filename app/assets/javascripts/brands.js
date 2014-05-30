$(document).ready(function(){	
	var $di = $('.ds_in')
	var cap_max_tit = 40;
  	var $cap_tit = $('#b_cap_nam')

	$('.b_ct_nam').html(cap_max_tit);

	$cap_tit.keyup(function(){	
		var cap_length = $cap_tit.val().length;
		var cap_remaining = cap_max_tit - cap_length;

		$('.b_ct_nam').html(cap_remaining);

		if (cap_remaining <= 10){
			$('.b_ct_nam').css('color', '#c72835');
		}else{
			$('.b_ct_nam').css('color', '#8930c7');
		};
	});

	$di.autosize();

});