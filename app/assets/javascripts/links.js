$(document).ready(function() {

    var $spinner = $('#spinner.spinner');

    $("a[href^=http]").each(function(){
      if(this.href.indexOf(location.hostname) == -1) {
         $(this).attr({
            target: "_blank",
         });
      }
    })

    $(window).scroll(function(){
        if ($(this).scrollTop() > 400) {
            $('.scrollup').fadeIn();
        } else {
            $('.scrollup').fadeOut();
        }
    });

    $('.scrollup').click(function(){
      $("html, body").animate({ scrollTop: 0 }, 600);
      return false;
    });

    $spinner.hide();  // hide it initially.

    $('form[data-remote]').bind('ajax:beforeSend', function(){
      $spinner.show();
    });

    $('form[data-remote]').bind('ajax:complete', function(){
      $spinner.hide();
    });

    $('form[data-remote]').bind('ajax:error', function(){
      $spinner.hide();
    });

});
