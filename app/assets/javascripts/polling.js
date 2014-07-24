$(document).ready(function(){

	var InboxPoller;

	InboxPoller = {
	  poll: function() {
	    return setTimeout(this.request, 5000);
	  },
	  request: function() {
	    return $.getScript($('.inbox_wrap').data('url'), {
	    	after: function() {
	    		$('.conversation').last().data('id')
	    	}
	    });
	  }
	};

	$(function() {
	  if ($('.inbox_wrap').length > 0) {
	    return InboxPoller.poll();
	  }
	});

});