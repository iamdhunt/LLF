$(document).ready(function(){
	$('.newsticker').smarticker({
		theme: 1,
		animation: 'default',
		controllerType: 1,
		rssFeed: 'http://billboard.feedsportal.com/c/34735/f/639534/index.rss', 
		rssSources: 'Billboard,Art News,ESPN,Entrepreneur,Complex,Dezeen,Extreme.com,Young Entrepreneur,Rolling Stone,American Photo,Bleacher Report,Inc.,Pitchfork,Digital Arts,Extreme Sports,Wired,Magnetic Mag,Film Magazine,SB Nation,Forbes,Pitchfork,Apparel News,Businessweek,Pitchfork,Art in America,Yahoo Business,Yahoo Sports,Digital Arts,Yahoo Fashion,Wired',
		rssCats: 'Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Entrepreneurial,Music,Arts,Entrepreneurial,Sports,Entrepreneurial,Arts,Entrepreneurial',
		rssColors: 'F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,2D9FC4,F7B448,74cfae,2D9FC4,EB6361,2D9FC4,74cfae,2D9FC4',
		rssLimit:4,		
		linkTarget:'_blank',
		pausetime: 3500
	});

});