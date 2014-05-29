$(document).ready(function() {
	var $li = $('.loc_in')
  	var $ai = $('.adr_in')
  	var $ci = $('.cit_in')
	var max_loc = 30;
  	var $loc = $('#e_loc_in')
  	var dom = document.getElementById('e_loc_in');

	if(dom != null) {
		var loc_length = $loc.val().length;
		var loc_remaining = max_loc - loc_length;
		$('.e_ct_loc').html(loc_remaining);

		if (loc_remaining <= 10){
			$('.e_ct_loc').css('color', '#c72835');
		}else{
			$('.e_ct_loc').css('color', '#444');
		};

		$loc.keyup(function(){	
			var loc_length = $loc.val().length;
			var loc_remaining = max_loc - loc_length;

			$('.e_ct_loc').html(loc_remaining);

			if (loc_remaining <= 10){
				$('.e_ct_loc').css('color', '#c72835');
			}else{
				$('.e_ct_loc').css('color', '#8930c7');
			};
		});
	};

	$li.autosize();
	$ai.autosize();
	$ci.autosize();

});