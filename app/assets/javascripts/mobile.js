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
       $( "#custom-search-input input" ).css( "width", "70%" );
       $( ".nav_search.l_o #custom-search-input" ).css( "margin-left", "300px" );
       $( ".nav_search #custom-search-input" ).css( "margin-left", "300px" );
       $( "#faqs_wrap" ).css( "padding-left", "1%" );
       $( "#faqs_wrap" ).css( "padding-right", "1%" );
       $( "#custom-search-input input" ).css( "font-size", "1em" );
       $( "#edit_wrap #when .input-group-addon" ).css( "padding", "6px 0 6px 0" );
       $( "#banner" ).css( "background-attachment", "inherit" );
       $( ".nav_search #custom-search-input" ).css( "margin-left", "300px" );
       $( ".md_aud_wrap .ui360 .sm2-360btn" ).css( 'width' , '270px' );
       $( ".md_aud_wrap .ui360 .sm2-360btn" ).css( 'height' , '243px' );
       $( ".md_aud_wrap .ui360-vis" ).css( 'width' , '305px' );
       $( ".md_aud_wrap .ui360-vis" ).css( 'height' , '317px' );
       $( ".md_aud_wrap .ui360-vis .sm2-360ui.sm2_playing .sm2-360btn" ).css( 'margin-left' , '45px' );
       $( ".md_aud_wrap .ui360-vis .sm2-360ui.sm2_playing .sm2-360btn" ).css( 'margin-top' , '38px' );
       $( ".md_aud_wrap .ui360-vis .sm2-360ui.sm2_paused .sm2-360btn" ).css( 'margin-left' , '45px' );
       $( ".md_aud_wrap .ui360-vis .sm2-360ui.sm2_paused .sm2-360btn" ).css( 'margin-top' , '38px' );
       $( ".md_aud_wrap .ui360 .sm2-timing" ).css( 'left' , '70px' );
       $( ".md_aud_wrap .ui360 .sm2-timing" ).css( 'top' , '75%' );
       $( ".md_aud_wrap .ui360 .sm2-canvas" ).css( 'left' , '70px' );
       $( ".md_aud_wrap .ui360 .sm2-canvas" ).css( 'top' , '55px' );
    }

});