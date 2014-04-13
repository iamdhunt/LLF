$(document).ready(function(){
	$('.newsticker').smarticker({
		theme: 1,
		animation: 'default',
		controllerType: 1,
		rssFeed: 'http://billboard.feedsportal.com/c/34735/f/639534/index.rss,http://www.artnews.com/feed,http://sports.espn.go.com/espn/rss/news,http://www.businessweek.com/feeds/most-popular.rss,http://cdnl.complex.com/feeds/channels/music.xml,http://news.yahoo.com/rss/fashion,http://news.yahoo.com/rss/sports,http://feeds.feedburner.com/entrepreneur/latest,http://www.rollingstone.com/siteServices/rss/musicNewsAndFeature,http://rss.feedsportal.com/c/662/f/8410/index.rss,http://feeds.feedburner.com/sportsblogs/sbnation.xml,http://news.yahoo.com/rss/business,http://pitchfork.com/rss/news/,http://www.artinamericamagazine.com/rss/,http://extremesportsx.com/feed,http://feeds.feedburner.com/YoungentrepreneurcomBlog,http://feeds.feedburner.com/magneticmag,http://www.americanphotomag.com/rss.xml,http://sports.espn.go.com/espn/rss/action/news,http://feeds.inc.com/home/updates,http://pitchfork.com/rss/features/,http://feeds.feedburner.com/FM_Blog,http://www.wired.com/business/feed/,http://pitchfork.com/rss/tours/,http://feeds.feedburner.com/dezeen,http://www.wired.com/insights/feed/,http://bleacherreport.com/articles/feed,http://www.apparelnews.net/rss/headlines/,http://rss.feedsportal.com/c/662/f/531250/index.rss,http://www.forbes.com/entrepreneurs/index.xml',	
		rssSources: 'Billboard,Art News,ESPN,Businessweek,Complex,Yahoo Fashion,Yahoo Sports,Entrepreneur,Rolling Stone,Digital Arts,SB Nation,Yahoo Business,Pitchfork,Art in America,Extreme Sports,Young Entrepreneur,Magnetic Mag,American Photo,ESPN Action,Inc.,Pitchfork,Film Magazine,Wired,Pitchfork,Dezeen,Wired,Bleacher Report,Apparel News,Digital Arts,Forbes',
		rssCats: 'Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Entrepreneurial,Music,Arts,Entrepreneurial,Sports,Entrepreneurial,Arts,Entrepreneurial',
		rssColors: 'F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,2D9FC4,F7B448,74cfae,2D9FC4,EB6361,2D9FC4,74cfae,2D9FC4',
		rssLimit:4,
		feedsOrder:'newer',		
		linkTarget:'_blank',
		pausetime: 3500
	});

});