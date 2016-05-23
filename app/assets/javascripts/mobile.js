$(document).ready(function(){

    if(isMobile.any()) {
       $( "#nav_bar" ).css( "position", "relative" );
       $( "#pagewrap" ).css( "padding-top", "0" );
       $( "#profile_wrap" ).css( "width", "95%" );
       $( "#e_wrapper" ).css( "width", "98%" );
       $( "#content_wrap" ).css( "width", "98%" );
       $( "#main_wrap" ).css( "width", "98%" );
       $( "#home_wrapper" ).css( "background-image", "url('/assets/Registration 2.png')" );
       $( "#e_404 #error_wrap" ).css( "background-image", "url('/assets/FAQs Main 2.png')" );
       $( ".login_bg" ).css( "background-image", "url('/assets/Login Banner 2.png')" );
       $( ".login_bg").css( "padding-top", "12%" );
       $( ".login_bg").css( "padding-bottom", "12%" );
       $( "#e_wrapper .nav-tabs li").css( "font-size", "1.3em" );
       $( "#faqs_wrap .nav-tabs li").css( "font-size", "1.3em" );
       $( ".primary_nav").css( "display", "none" );
       $( ".primary_nav2").css( "display", "inline" );
       $( ".fr-sticky-on").css( "top", "0px !important" );
       $( "#custom-search-input input" ).css( "width", "85%" );
       $( ".nav_search.l_o #custom-search-input" ).css( "margin-left", "205px" );
       $( ".nav_search #custom-search-input" ).css( "margin-left", "205px" );
       $( "#faqs_wrap" ).css( "padding-left", "1%" );
       $( "#faqs_wrap" ).css( "padding-right", "1%" );
       $( "#custom-search-input input" ).css( "font-size", "1em" );
       $( "#pb").css( "text-align", "center !important" );
    }

});