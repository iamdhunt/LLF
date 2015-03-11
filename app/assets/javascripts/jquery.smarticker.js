/*
 * SmarTicker Version 1.5
 * http://powerup.ir/projects/smarticker
 * Copyright (c) 2014 Meghdad Hadidi
 */
 (function($){
	$.fn.smarticker = function(options){
		var defaults;
		var settings = $.extend({
			pause: 0,
			maxWidth: 0,
			el: $(this),
			timeouts:[],
			nx:'start',
			newsRollerIndex:0,
			lastIndex:99999,
			clearTimeouts: function(){
				for(var i = 0, z = settings.timeouts.length; i < z; i++){
					clearTimeout(settings.timeouts[i]);
				}
				settings.timeouts = [];
				$('*',settings.el).clearQueue(); 
			}
		},$.fn.smarticker.defaults, options);

		return this.each(function(index){
			// Set the variables from our page elements
			var element = $(this);
			var smartickerCats = $('<div class="smarticker-cats"><ul></ul></div>');
			var smartickerCategory = $('<div class="smarticker-category"><ul></ul></div>');
			settings.newsRollerIndex = settings.startindex;
			var smartController = $('<div class="smart-controller"><span class="prev-news">Previous</span><span class="pause-news">Pause</span><span class="next-news">Next</span></div>').css('background',element.css('background'));
			var progressBar = $('<div class="progress-bar"></div>');
			var titlebar = $('<div class="sec1-2 tickertitle"></div>');
			// Find News Items
			var newsItems = $('li', element);
			
			$('li',element).css('display','none');


			// If Rss Feed exists
			// Start of rss feed parsing
			if($.trim(settings.rssFeed) != ''){
				element.append('<div class="loading" Style="text-align:center;color:#666;font-size:12px">Loading Rss feed, Please wait ...</div>');
				var fds = settings.rssFeed.split(',');
				var fdsSource = [];
				var fdsCat = [];
				var fdsColor = [];
				if(settings.rssCats) fdsCat = settings.rssCats.split(',');
				if(settings.rssSources) fdsSource = settings.rssSources.split(',');
				if(settings.rssColors) fdsColor = settings.rssColors.split(',');
				if(settings.imagesPath[settings.imagesPath.length-1] != '/' && settings.imagesPath != '') settings.imagesPath = settings.imagesPath+'/';


				var feedCounter = 0;

				function feedRead(){

					var url = $.trim(fds[feedCounter]);
					if(settings.category != false){
						if(fdsSource[feedCounter] != undefined){
							fdsSource[feedCounter] = 'data-category="'+fdsSource[feedCounter]+'"';
						}
						else{
							fdsSource[feedCounter] = 'data-category="Rss"';
						}
					} 
					else{
						fdsSource[feedCounter] = '';
					}
					if(settings.subcategory != false){
						if(fdsCat[feedCounter] != undefined){
							fdsCat[feedCounter] = 'data-subcategory="'+fdsCat[feedCounter]+'"';
						}
						else{
							fdsCat[feedCounter] = 'data-subcategory="Feed"';
						}
					} 
					else{
						fdsCat[feedCounter] = '';
					}
					if(fdsColor[feedCounter] != undefined){
						fdsColor[feedCounter] = 'data-color="'+fdsColor[feedCounter]+'"';
					}
					else{
						fdsColor[feedCounter] = 'data-color="c3c3c3"';
					}



					//url = $.trim(url);
					
					var target = element;
	            	if(element.find('ul').length > 0) target = element.find('ul');
	            	if(element.find('ul').length == 0){
	            		target.append('<ul></ul>');
	            		target = element.find('ul');
	            	}

	            	if(settings.feedLoader == '') settings.googleApi = true;

	            	element.addClass('google-api');
	            	var ajaxUrl = window.location.protocol + '//ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=' + settings.rssLimit + '&callback=?&q=' + encodeURIComponent(url);
	            	var ajaxData;
	            	

	            	if(!settings.googleApi || settings.feedLoader != ''){
	            		element.removeClass('google-api').addClass('feed-loader');
	            		ajaxUrl = settings.feedLoader;

		            	ajaxData = {
		            		siteurl: url,
					        limit:settings.rssLimit
		            	}
	            	}


	            	$.ajax({
						type: "GET",
				        url: ajaxUrl,
				        data: ajaxData,
				        dataType: 'json',
				        beforeSend: function(){
				        	$('.loading',element).text('Loading feed '+(feedCounter+1)+' of '+fds.length)
				        },
				        error: function(){
				            logThis('Unable to load feed, Incorrect path or invalid feed');
				        },
				        success: function(xml){

				            var values;
				            
				            if(!settings.googleApi || settings.feedLoader != '') values = xml.item;
				            else values = xml.responseData.feed.entries;
				            $.each(values,function(key,item){
				            	var item = $(this)[0];
				            	var itemObj = $('<li style="display:none" ' + fdsColor[feedCounter] + ' ' + fdsCat[feedCounter] + ' ' + fdsSource[feedCounter] + '><a target="'+settings.linkTarget+'" href="'+item.link+'"></a></li>');
				            	itemObj.find('a').text(item.title);
				            	var target = element;
				            	var date;
				            	if(item.pubdate != undefined || item.pubdate != '' || item.pubdate != NaN) date = item.pubdate;
				            	date =  new Date(date);
								var months = Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
								var dateString = date.getDate() + " " + months[date.getMonth()] + " " + date.getFullYear();
								if(settings.showDate != '' || settings.showDate != false && item.pubdate != undefined) $('<span class="item-date">'+dateString+'</span>').appendTo(itemObj);
				            	if(element.find('ul').length > 0) target = element.find('ul');
				            	if(settings.feedsOrder == 'older') itemObj.appendTo(target);
				            	else itemObj.prependTo(target);
				            	if(key == values.length-1){
				            		if(feedCounter == fds.length-1){
										$('.loading',element).fadeOut(200,function(){
							        		$('.loading',element).remove();
							        	});
							        	createStructure();
									}
									else{
										feedCounter++;
					            		feedRead();
									}
				            	}
				            });
				        }
					});

				}

				feedRead();

			}

						else{
							createStructure();
						}
						// End Of Rss feed Parsing
						function createStructure(){
							// Get Fresh list of News
							newsItems = $('li', element);
							// Wrap list of news to a DIV
							element.addClass('smarticker').wrapInner('<div class="smarticker-news"></div>');

							// Creating news, category and subcategory list
							if(settings.shuffle) $('li', element).randomize();
							if(unique(newsItems, 'subcategory').length < 1) settings.subcategory = false;
							if(unique(newsItems, 'category').length < 1) settings.category = false;


							// Generate list of subcategories if exists
							if(settings.subcategory == true){
								smartickerCats.prependTo(element).addClass('sec1-2');
								$.each(unique(newsItems, 'subcategory'), function(i,e){
									var newE = e;
									if(e.indexOf('.png') != -1 || e.indexOf('.jpg') != -1 || e.indexOf('.gif') != -1){
										newE = '<img src="'+settings.imagesPath+e+'" />'
									}
									smartickerCats.find('ul').append('<li data-subcategory="'+e+'"><a>'+newE+'</a></li>');
								});
								if(settings.theme == 1 || settings.theme == 2){
									smartickerCats.find('ul').wrap('<div class="catlist"></div>');
									smartickerCats.append('<span class="right"></span>').prepend('<span class="left"></span>');
								}
							}

							// Generate list of categories if exists	
							if(settings.category == true && unique(newsItems, 'category').length > 0){
								smartickerCategory.prependTo(element).addClass('sec1-2');
								$.each(unique(newsItems, 'category'), function(i,e){
									var newE = e;
									if(e.indexOf('.png') != -1 || e.indexOf('.jpg') != -1 || e.indexOf('.gif') != -1){
										newE = '<img src="'+settings.imagesPath+e+'" />'
									}
									smartickerCategory.find('ul').append('<li data-category="'+e+'"><a>'+newE+'</a></li>');
								});
							}


							if(settings.layout == 'horizontal'){
								// Add some features depends on settings
								if(settings.progressbar == true) progressBar.appendTo($('.smarticker-news', element));
								if(settings.controllerType != false) smartController.appendTo(element);
								if(settings.category == false) element.addClass('no-category');
								if(settings.subcategory == false) element.addClass('no-subcategory');
								element.addClass('theme'+settings.theme);
								element.addClass('box size1');
								element.addClass('c'+settings.controllerType);
								element.addClass('s-'+settings.direction);

								$('.smarticker-news', element).addClass('sec7 newsholder');
								$('.smarticker-news > ul', element).attr('id','newsholder').addClass('newsholder');
								if(settings.rounded == true) element.addClass('rounded');
								if(settings.direction == 'rtl') element.addClass('rtl');
								if(settings.border == true) element.addClass('border');
								if(settings.shadow == true) element.addClass('shadow');
								if(settings.googleFont == true) element.addClass('googlefont');
								if(settings.category == false || settings.subcategory == false){
									$('.smarticker-news', element).removeClass('sec7').addClass('sec10');
								}
								if(settings.category == false && settings.subcategory == false && settings.titlesection == true){
									$('.smarticker-news', element).removeClass('sec7').addClass('sec10');
									titlebar.prependTo(element).text(settings.title);
								}
								// Start running SmarTicker
								nextCategory();

								$('.next-news',element).on('click',function(){
									if(newsItems.length < 2) return false;
									settings.pause = 1;
									settings.nx = 'next';
									settings.clearTimeouts();
									nextCategory();
									if(!$('.pause-news').hasClass('play-news')) settings.pause = 0;
								});
								$('.prev-news',element).on('click',function(){
									if(newsItems.length < 2) return false;
									settings.pause = 1;
									settings.nx = 'prev';
									settings.clearTimeouts();
									nextCategory();
									settings.nx = 'next';
									if(!$('.pause-news').hasClass('play-news')) settings.pause = 0;
								});
								$('.pause-news',element).on('click',function(){
									if(newsItems.length < 2) return false;
									if($(this).hasClass('play-news')){
										settings.pause = 0;
										nextCategory();

										$(this).removeClass('play-news')
										.text('Pause');
									}
									else{
										settings.clearTimeouts();
										settings.pause = 1;

										$(this).addClass('play-news')
										.text('Play');	
									}
								});
							}
							if(settings.layout == 'vertical'){
								logThis('Excuse me! Vertical layout is not available in this version, Please use Horizontal layout!');
							}
							else{
								logThis('Layout type not valid! It must be Vertical Or Horizontal');
							}
						}

						// Functions for remove duplicates from subcategory and category list
						function unique(list,section) {
						  var result = [];
						  $.each(list, function(i, e) {
						    if ($.inArray($(e).data(section), result) == -1 && $(e).data(section) != undefined) result.push($(e).data(section));
						  });
						  return shuffle(result);
						}

						// Functions for randomize subcategory and category list
						function shuffle(arr){
						  for(var j, x, i = arr.length; i; j = parseInt(Math.random() * i), x = arr[--i], arr[i] = arr[j], arr[j] = x);
						  return arr;
						}

						function changeIndex(){
							if(newsItems.length < 2) return false;
							if(settings.nx != 'start'){
								settings.lastIndex = settings.newsRollerIndex;
							}
							if(!settings.nx || settings.nx == 'next' || settings.nx == 'start'){
								if(settings.nx != 'start') settings.newsRollerIndex++;
								if(settings.newsRollerIndex == $('.newsholder', element).find('li').length) settings.newsRollerIndex = 0;
								settings.nx = 'next';
							}
							if(settings.nx && settings.nx == 'prev'){
								settings.newsRollerIndex--;
								if(settings.newsRollerIndex == -1) settings.newsRollerIndex = $('.newsholder', element).find('li').length-1;
							}
						}
						// Ticker will start from category
						function nextCategory(){
							changeIndex();
							settings.clearTimeouts();
							if(settings.category == false || $('.smarticker-news ul li', element).eq(settings.lastIndex).data('category') == $('.smarticker-news ul li', element).eq(settings.newsRollerIndex).data('category')){
								nextSubcategory();
							}
							else{
								$('.active-ag', element).removeClass('active-ag');
								var category = $('.newsholder li', element).eq(settings.newsRollerIndex).data('category');
								category = $('.smarticker-category ul li', element).index($('.smarticker-category ul li[data-category="'+category+'"]', element));
								$('.smarticker-category ul li', element).eq(category).addClass('active-ag');
								category = $('.active-ag', element);
								$('.smarticker-category', element).animate({
									scrollTop: category.offset().top - category.parent().offset().top + category.parent().scrollTop()
								},settings.speed - (settings.speed/2.5),function(){
									if(settings.subcategory != false){
										nextSubcategory();
									}
									else{
										nextNews();
									}

									// Change background color of category section with animate() method
									var categorycolor = $('.newsholder', element).find('li').eq(settings.newsRollerIndex).data('color');
									if(categorycolor != undefined && settings.catcolor != false){
										$('.active-ag a', element).stop().animate({color:'#'+categorycolor},settings.speed - (settings.speed/2.5));
									}
									else $('.active-ag a', element).stop().animate({color:'#999'},settings.speed - (settings.speed/2.5));

								});
							}
						}

						function nextSubcategory(){
							if(settings.subcategory == false || $('.smarticker-news ul li', element).eq(settings.lastIndex).data('subcategory') == $('.smarticker-news ul li', element).eq(settings.newsRollerIndex).data('subcategory')){
								logThis('Last index subcategory: '+settings.lastIndex+'='+$('.smarticker-news ul li', element).eq(settings.lastIndex).data('subcategory'));
								logThis('This subcategory: '+ settings.newsRollerIndex+'='+$('.smarticker-news ul li', element).eq(settings.newsRollerIndex).data('subcategory'));
								if($('.smarticker-news ul li', element).eq(settings.newsRollerIndex).data('color') == $('.smarticker-news ul li', element).eq(settings.lastIndex).data('color')){
									nextNews();
									return false;
								}					

							}
							$('.active-cat', element).removeClass('active-cat');
							var subcategory = $('.newsholder li', element).eq(settings.newsRollerIndex).data('subcategory');
							subcategory = $('.smarticker-cats li', element).index($('.smarticker-cats li[data-subcategory="'+subcategory+'"]', element));
							$('.smarticker-cats ul li', element).eq(subcategory).addClass('active-cat');
							subcategory = $('.active-cat', element);
							var subcategoryParent = subcategory.parent();
							if($('.catlist', element).length > 0) subcategoryParent = $('.catlist', element);
							else subcategoryParent = $('.smarticker-cats', element);
							subcategoryParent.animate({
								scrollTop: Math.max(subcategory.offset().top - subcategoryParent.offset().top + subcategoryParent.scrollTop(),0)
							},settings.speed - (settings.speed/2.5),nextNews);
							var subcategorycolor = $('.newsholder', element).find('li').eq(settings.newsRollerIndex).data('color');

							// Change background color of subcategory section with animate() method
							if(subcategorycolor != undefined && settings.subcatcolor != false){
								$('.smarticker-cats li', element).animate({backgroundColor:'#'+subcategorycolor},settings.speed - (settings.speed/2.5));
							}
							else $('.smarticker-cats li', element).animate({backgroundColor:'#c3c3c3'},settings.speed - (settings.speed/2.5));
						}

						// Now it's time to change news title			
						function nextNews(){
							//settings.pause = 0;
							$('.newsholder', element).css({
								'display':'block',
								'height':'100%'
							});

							progressBar.css('width','100%').animate({width:0},settings.pausetime);

							// Detect animation type depend on settings, then choose one of these options
							if(settings.animation == 'default'){
								if($('.activeRollerItem', element).length > 0){
									var activeItem = $('.activeRollerItem', element);
									activeItem.animate({top:-25,opacity:0},settings.speed - (settings.speed/1.2),function(){activeItem.css('display','none')}).removeClass('activeRollerItem');
								}
								var thisItem = $('.newsholder', element).find('li').eq(settings.newsRollerIndex).addClass('activeRollerItem');
								thisItem.css({'top':'25px','display':'block'}).animate({opacity:1,top:0},settings.speed - (settings.speed/2.5),function(){
									//settings.newsRollerIndex++;
									//if(settings.newsRollerIndex == $('.newsholder', element).find('li').length) settings.newsRollerIndex = 0;
									showTail();
								});
							}
							if(settings.animation == 'slide'){
								if(settings.direction == 'ltr'){
									if($('.activeRollerItem', element).length > 0){
										activeItem = $('.activeRollerItem', element);
										activeItem.animate({left:250,opacity:0},settings.speed - (settings.speed/1.5),function(){activeItem.css('display','none')}).removeClass('activeRollerItem');
									}
									var thisItem = $('.newsholder li', element).eq(settings.newsRollerIndex).addClass('activeRollerItem');
									thisItem.css({'left':'-150px','display':'block','opacity':'1'}).animate({opacity:1,left:10},settings.speed - (settings.speed/3),function(){
										//settings.newsRollerIndex++;
										//if(settings.newsRollerIndex == $('.newsholder li', element).length) settings.newsRollerIndex = 0;
										showTail();
									});
								}
								else{
									if($('.activeRollerItem', element).length > 0){
										activeItem = $('.activeRollerItem', element);
										activeItem.animate({right:250,opacity:0},settings.speed - (settings.speed/1.5),function(){activeItem.css('display','none')}).removeClass('activeRollerItem');
									}
									var thisItem = $('.newsholder li', element).eq(settings.newsRollerIndex).addClass('activeRollerItem');
									thisItem.css({'right':'-150px','display':'block','opacity':'1'}).animate({opacity:1,right:10},settings.speed - (settings.speed/3),function(){
										//settings.newsRollerIndex++;
										//if(settings.newsRollerIndex == $('.newsholder li', element).length) settings.newsRollerIndex = 0;
										showTail();
									});
								}
							}

							if(settings.animation == 'fade'){
								if($('.activeRollerItem', element).length > 0){
									activeItem = $('.activeRollerItem', element);
									activeItem.fadeOut(settings.speed/2,function(){
										activeItem.removeClass('activeRollerItem');
									});
								}
								var thisItem = $('.newsholder li', element).eq(settings.newsRollerIndex).addClass('activeRollerItem');
								thisItem.css({'top':'0','display':'none'}).fadeIn(settings.speed/2,function(){
									//settings.newsRollerIndex++;
									//if(settings.newsRollerIndex == $('.newsholder li', element).length) settings.newsRollerIndex = 0;
									showTail();
								});
							}

							if(settings.animation == 'typing'){
								if($('.activeRollerItem', element).length > 0){
									activeItem = $('.activeRollerItem', element);
									var hider = $('<div class="hider"></div>');
									var dir = 'left';
									if(settings.direction == 'rtl') dir = 'right';
									hider.prependTo($('.smarticker-news', element)).css({
										'width':'0px',
										dir:'0px',
										'height':'100%',
										'position':'absolute',
										'background-color':element.css('background-color'),
										'z-index':'2'
									})
									hider.animate({width:activeItem.width()+30},settings.speed,function(){
										activeItem.fadeOut(100,function(){
											activeItem.css('opacity','0').removeClass('activeRollerItem');
											hider.fadeOut(100,function(){
												var thisItem = $('.newsholder li', element).eq(settings.newsRollerIndex).addClass('activeRollerItem').css({
													'display':'block',
													'opacity':'1'
												});
												hider.remove();
												var cover = $('<div class="cover"><div class="flasher">_</div></div>');
												cover.prependTo($('.smarticker-news', element));
												cover.css({
													'background-color':element.css('background-color')
												});
												if(settings.direction == 'ltr'){
													cover.animate({left:thisItem.width()+30},thisItem.width()*8,
														function(){
															cover.remove();
															//settings.newsRollerIndex++;
															//if(settings.newsRollerIndex == $('.newsholder li', element).length) settings.newsRollerIndex = 0;
															showTail();
														}
													);	
												}
												else{
													cover.animate({right:thisItem.width()+30},thisItem.width()*8,
														function(){
															cover.remove();
															//settings.newsRollerIndex++;
															//if(settings.newsRollerIndex == $('.newsholder li', element).length) settings.newsRollerIndex = 0;
															showTail();
														}
													);
												}

											});
										});
									});
								}
								else{
									var thisItem = $('.newsholder li', element).eq(settings.newsRollerIndex).addClass('activeRollerItem').css({
										'display':'block',
										'opacity':'1'
									});
									var cover = $('<div class="cover"><div class="flasher">_</div></div>');
									cover.prependTo($('.smarticker-news', element));
									cover.css({
										'background-color':element.css('background-color')
									});
									if(settings.direction == 'ltr'){
										cover.animate({left:thisItem.width()+30},thisItem.width()*8,function(){
											cover.remove();
											if(settings.pause == 0){
												//settings.newsRollerIndex++;
												//if(settings.newsRollerIndex == $('.newsholder li', element).length) settings.newsRollerIndex = 0;
												showTail();
											}
										});	
									}
									else{
										cover.animate({right:thisItem.width()+30},thisItem.width()*8,function(){
											cover.remove();
											if(settings.pause == 0){
												//settings.newsRollerIndex++;
												//if(settings.newsRollerIndex == $('.newsholder li', element).length) settings.newsRollerIndex = 0;
												showTail();
											}
										});
									}

								}
							}	
						}
						function showTail(){
							settings.maxWidth = 0;
							settings.maxWidth = element.width();
							settings.maxWidth = settings.maxWidth - $('.smarticker-cats',element).width();
							settings.maxWidth = settings.maxWidth - $('.smarticker-category',element).width();
							if(settings.smartController != false) settings.maxWidth = settings.maxWidth - $('.smart-controller',element).width();
							logThis('element: '+$('.activeRollerItem',element).width());
							logThis('max: '+settings.maxWidth);
							if($('.activeRollerItem',element).width() > settings.maxWidth){
								settings.maxWidth = $('.activeRollerItem',element).width() - settings.maxWidth + 10;
								$('.activeRollerItem',element).css('display','block');

								if(settings.direction == 'rtl'){
									$('.activeRollerItem',element)
									.css('left','auto')
									.animate({right:10},250)
									.delay(1000)
									.animate({right:-settings.maxWidth},settings.maxWidth*30,function(){
										$('.activeRollerItem',element)
										.delay(1000)
										.animate({right:10},300,function(){
											if(newsItems.length < 2) return false;
											setNextTimeout();
										});
									});
								}
								else{
									$('.activeRollerItem',element).animate({left:10},250)
									.delay(1000)
									.animate({left:-settings.maxWidth},settings.maxWidth*30,function(){
										$('.activeRollerItem',element)
										.delay(1000)
										.animate({left:10},300,function(){
											if(newsItems.length < 2) return false;
											setNextTimeout();
										});
									});
								}
							}
							else{
								if(newsItems.length < 2) return false;
								setNextTimeout();
							}
						}
						function setNextTimeout(){
							if(settings.pause != 1){
								settings.timeouts.push(setTimeout(nextCategory,settings.pausetime));
							}
						}

						function logThis(message){
							if(settings.developerMode == true){
								console.log(message);
							}
						}

					})
				}
				// SmarTicker default options
				$.fn.smarticker.defaults = {
					theme: 1, 				// Defines SmarTicker Style: 1, 2, 3, 4 ...
					direction: 'ltr',
					layout: 'horizontal',
					animation: 'default',	// Defines transition of news titles: default, fade, slide, ...
					speed: 1000,			// Defines speed of transition for subcategory, category and news
					startindex: 0,			// Starter index
					pausetime: 3000,		// Pause time on each news
					rounded: false,			// Add border radius to parent node
					shadow: true,			// Add box-shadow to parent node
					border: false,			// Add 1px solid border to parent node
					category: true,			// If change this to false, the Category section will not be created
					subcategory: true,		// If change this to false, the Subcategory section will not be created
					titlesection: true,
					title: 'Headlines',		// When category and subcategory not available this section will show
					progressbar: false,		// Add a progress bar
					catcolor: true,			// Animate category section background color
					subcatcolor: true,		// Animate sub category section background color
					shuffle:false,
					rssFeed: '',
					rssLimit: 10,
					rssCats: '',
					rssSources: '',
					rssColors: '',
					showDate:false,
					googleApi:true,
					feedLoader:'',
					feedsOrder:'older',
					linkTarget:'_blank',
					controllerType: false,
					googleFont: true,
					imagesPath:'',
					developerMode: false
				}
			})(jQuery);


(function($){
 
    $.fn.randomize = function() {
 
        var allElems = this.get(),
            getRandom = function(max) {
                return Math.floor(Math.random() * max);
            },
            randomized = $.map(allElems, function(){
                var random = getRandom(allElems.length),
                    randEl = $(allElems[random]).clone(true)[0];
                allElems.splice(random, 1);
                return randEl;
           });
 
        this.each(function(i){
            $(this).replaceWith($(randomized[i]));
        });
 
        return $(randomized);
 
    };
 
})(jQuery);