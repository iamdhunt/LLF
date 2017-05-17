$(document).ready(function() {

    var $spinner = $('#spinner.spinner');
    var $refresh = $('i', '.refresh');

    $("a[href^=http]").not('a[href*="s3.amazonaws"]').each(function(){
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

    $("#b_arrow").click(function() {
        var offset = 70;

        $('html, body').animate({
            scrollTop: $(".scroll2").offset().top
        }, 1000);
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

    $('a', '.refresh').bind('ajax:beforeSend', function(){
      $refresh.addClass('fa-spin');
    });

    $('a', '.refresh').bind('ajax:complete', function(){
      $refresh.removeClass('fa-spin', {duration:500});
    });

    $('#a_top .options').click(function() {
        var $ovly = $(this).data("ovly");
        $('#' + $ovly).toggleClass("none");
    });

    $('body').on('click', '.btn.share', function() {
        var $ovly = $(this).data("ovly");
        $('#' + $ovly).toggleClass("none");
    });

    $('.pdl_action').on('click', '.share', function() {
        var $ovly = $(this).data("ovly");
        $('#' + $ovly).toggleClass("none");
    });

    $('body').on('click', '#p_list_top .share', function() {
        var $ovly = $(this).data("ovly");
        $('#' + $ovly).toggleClass("none");
    });

});
