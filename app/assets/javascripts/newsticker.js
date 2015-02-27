$(document).ready(function(){
	$('.newsticker').smarticker({
		theme: 1,
		animation: 'default',
		controllerType: 1,
		rssFeed: 'http://billboard.feedsportal.com/c/34735/f/639534/index.rss,http://www.artnews.com/feed,http://sports.espn.go.com/espn/rss/news,http://feeds.feedburner.com/entrepreneur/latest,http://cdnl.complex.com/feeds/channels/music.xml,http://feeds.feedburner.com/dezeen,http://extreme.com/rss,http://feeds.feedburner.com/YoungentrepreneurcomBlog,http://www.rollingstone.com/siteServices/rss/musicNewsAndFeature,http://www.americanphotomag.com/rss.xml,http://bleacherreport.com/articles/feed,http://feeds.inc.com/home/updates,http://pitchfork.com/rss/news/,http://rss.feedsportal.com/c/662/f/531250/index.rss,http://extremesportsx.com/feed,http://www.wired.com/business/feed/,http://feeds.feedburner.com/magneticmag,http://feeds.feedburner.com/FM_Blog,http://feeds.feedburner.com/sportsblogs/sbnation.xml,http://www.forbes.com/entrepreneurs/index.xml,http://pitchfork.com/rss/features/,http://www.apparelnews.net/rss/headlines/,http://www.businessweek.com/feeds/most-popular.rss,http://pitchfork.com/rss/tours/,http://www.artinamericamagazine.com/rss/,http://news.yahoo.com/rss/business,http://news.yahoo.com/rss/sports,http://rss.feedsportal.com/c/662/f/8410/index.rss,http://news.yahoo.com/rss/fashion,http://www.wired.com/insights/feed/', 
		rssSources: 'Billboard,Art News,ESPN,Entrepreneur,Complex,Dezeen,Extreme.com,Young Entrepreneur,Rolling Stone,American Photo,Bleacher Report,Inc.,Pitchfork,Digital Arts,Extreme Sports,Wired,Magnetic Mag,Film Magazine,SB Nation,Forbes,Pitchfork,Apparel News,Businessweek,Pitchfork,Art in America,Yahoo Business,Yahoo Sports,Digital Arts,Yahoo Fashion,Wired',
		rssCats: 'Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Sports,Entrepreneurial,Music,Arts,Entrepreneurial,Music,Arts,Entrepreneurial,Sports,Entrepreneurial,Arts,Entrepreneurial',
		rssColors: 'F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,EB6361,2D9FC4,F7B448,74cfae,2D9FC4,F7B448,74cfae,2D9FC4,EB6361,2D9FC4,74cfae,2D9FC4',
		rssLimit:4,		
		linkTarget:'_blank',
		pausetime: 3500
	});

});