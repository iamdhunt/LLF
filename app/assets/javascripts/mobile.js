$(document).ready(function(){

      if(isMobile.any()) {

            $( "#nav_bar" ).css( "position", "relative" );
            $( "#pagewrap" ).css( "padding-top", "0" );
            $( "#profile_wrap" ).css( "width", "95%" );
            $( "#e_wrapper" ).css( "width", "98%" );
            $( "#content_wrap" ).css( "width", "98%" );
            $( "#main_wrap" ).css( "width", "98%" );
            $( ".login_bg" ).css( "background-image", "url('/assets/Login Banner 2.png')" );
            $( ".login_bg").css( "padding-top", "12%" );
            $( ".login_bg").css( "padding-bottom", "12%" );
            $( "#e_wrapper .nav-tabs li").css( "font-size", "1.3em" );
            $( "#faqs_wrap .nav-tabs li").css( "font-size", "1.3em" );
            $( ".fr-sticky-on").css( "top", "0px !important" );
            $( "#nav_bar .primary_nav" ).css( "width", "290px" );
            $( ".nav_search.l_o #custom-search-input" ).css( "margin-left", "300px" );
            $( ".nav_search #custom-search-input" ).css( "margin-left", "300px" );
            $( "#faqs_wrap" ).css( "padding-left", "1%" );
            $( "#faqs_wrap" ).css( "padding-right", "1%" );
            $( "#custom-search-input input" ).css( "font-size", "1em" );
            $( "#edit_wrap #when .input-group-addon" ).css( "padding", "6px 0 6px 0" );
            $( "#banner" ).css( "background-attachment", "inherit" );
            $( ".nav_search #custom-search-input" ).css( "margin-left", "300px" );
            $( ".comment_del" ).css( "display", "inline" );
            $( ".conv_header .delete" ).css( "display", "inline" );
            $( ".conv_del" ).css( "display", "inline" );
            $( ".modal-dialog" ).css( "margin-top", "100px" );
            $( ".scrollup" ).css( "display", "none !important" );

            var cPosition = false;

            $('.modal').on('show.bs.modal', function(){

                  cPosition = $(window).scrollTop();
            })
            .on('shown.bs.modal', function(){

                  $('body.modal-open').css({
                    position:'fixed'
                  });

            })
            .on('hide.bs.modal', function(){

                  $('body.modal-open').css({
                    position:'',
                    overflow: ''
                  });

                  window.scrollTo(0, cPosition);

            });  
      } else {
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
      }

});