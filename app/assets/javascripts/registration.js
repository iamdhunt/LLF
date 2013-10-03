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
});