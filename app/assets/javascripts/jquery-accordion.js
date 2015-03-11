
(function($){
	jQuery.fn.jqueryAccordion = function(options){
		var settings = {
			interval	 			: 400,     	// animation time (ms)
			fadeContent			: false,		// content fading
			open					: false, 	// determines if the accordion starts with a item opened
			defaultOpenIndex	: 1,			// index of the item opened
			clickOutToClose	: false		// close accordion if the user click out of it
		}
		$.extend( settings, options );
		
		var accordion = $(this);
		
		if(settings.open == true){
			$(accordion).children(".accordion-item:nth-child(" + settings.defaultOpenIndex +")").children(".accordion-header").addClass("opened focus");
			$(accordion).children(".accordion-item:nth-child(" + settings.defaultOpenIndex +")").children(".accordion-content").show(0);
		}
		
		$(accordion).children(".accordion-item").children(".accordion-header").bind("click", function(){
			if($(this).siblings(".accordion-content").is(":hidden")){
				if(settings.fadeContent == true){
					$(accordion).children(".accordion-item").children(".accordion-content").children().animate({opacity: 0}, 0);
				}
				$(accordion).children(".accordion-item").children(".accordion-header").removeClass("opened focus");
				$(accordion).children(".accordion-item").children(".accordion-content").slideUp(settings.interval);
				$(this).siblings(".accordion-content").slideDown(settings.interval);
				$(this).addClass("opened focus");
				if(settings.fadeContent == true){
					var time = 0;
					for(var i = 1; i < $(this).siblings(".accordion-content").children().length + 1; i++){
						$(this).siblings(".accordion-content").children(":nth-child(" + i +")").delay(settings.interval + time).animate({opacity: 1}, 300);
						time = time + 100;
					}
				}
			}
			else{
				$(this).siblings(".accordion-content").slideUp(settings.interval);
				$(this).removeClass("opened focus");
			}
		});
		
		if(settings.clickOutToClose){
			$(document).bind("click", function(ev){
				if($(ev.target).closest(accordion).length == 0){
					$(accordion).find(".accordion-content").slideUp(settings.interval);
				}
			});
		}
		
	}
}(jQuery));