$(document).ready(function() {
	$(function () {
	    $("#reg_username")
	        .popover({ 
	        	title: 'Choose your username.',
	        	trigger: 'focus',
	        	html : true,
	        	content: function() {
			      return $('#pop_username_reg').html();
			    } 
	        })
	        .blur(function () {
	            $(this).popover('hide');
	        });
	});

	$(function () {
	    $("#reg_password")
	        .popover({ 
	        	title: 'Choose your password.',
	        	trigger: 'focus',
	        	html : true,
	        	content: function() {
			      return $('#pop_password_reg').html();
			    } 
	        })
	        .blur(function () {
	            $(this).popover('hide');
	        });
	});

	$(function () {
	    $("#reg_pursuits")
	        .popover({ 
	        	title: 'What are your favorite pursuits?',
	        	placement: 'left',
	        	trigger: 'focus',
	        	html : true,
	        	content: function() {
			      return $('#pop_pursuits_reg').html();
			    } 
	        })
	        .blur(function () {
	            $(this).popover('hide');
	        });
	});

	$(function () {
	    $("#reg_first")
	        .popover({ 
	        	title: 'Enter your first name.',
	        	placement: 'right',
	        	trigger: 'focus',
	        	html : true,
	        	content: function() {
			      return $('#pop_first_reg').html();
			    } 
	        })
	        .blur(function () {
	            $(this).popover('hide');
	        });
	});

	$(function () {
	    $("#reg_last")
	        .popover({ 
	        	title: 'Enter your last name.',
	        	placement: 'right',
	        	trigger: 'focus',
	        	html : true,
	        	content: function() {
			      return $('#pop_last_reg').html();
			    } 
	        })
	        .blur(function () {
	            $(this).popover('hide');
	        });
	});
});