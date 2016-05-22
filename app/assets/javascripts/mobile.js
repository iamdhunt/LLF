$(document).ready(function(){

    if(isMobile.any()) {
       $( "#nav_bar" ).css( "position", "relative" );
       $( "#pagewrap" ).css( "padding-top", "0" );
       $( "#profile_wrap" ).css( "width", "95%" );
       $( "#e_wrapper" ).css( "width", "98%" );
       $( "#content_wrap" ).css( "width", "98%" );
       $( "#main_wrap" ).css( "width", "98%" );
       $( "#pb" ).css( "padding-left", "15%" );
       $( "#home_wrapper" ).css( "background-image", "url('/assets/Registration 2.png')" );
       $( "#faq_bg" ).css( "background-image", "url('/assets/FAQs Main 2.png')" );
       $( ".login_bg" ).css( "background-image", "url('/assets/Login Banner 2.png')" );
       $( ".login_bg").css( "padding-top", "12%" );
       $( ".login_bg").css( "padding-bottom", "12%" );
       $( "#e_wrapper .nav-tabs li").css( "font-size", "1.3em" );
       $( "#primary_nav").css( "display", "none" );
       $( "#primary_nav2").css( "display", "inline" );
       $( ".fr-sticky-on").css( "top", "0px !important" );
       $( "#custom-search-input input" ).css( "width", "85%" );
       $( ".nav_search.l_o #custom-search-input" ).css( "margin-left", "190px" );
       $( ".nav_search #custom-search-input" ).css( "margin-left", "190px" );
       $( "#pb" ).css( "width", "98%" );
       $( "#faqs_wrap" ).css( "padding-left", "1%" );
       $( "#faqs_wrap" ).css( "padding-right", "1%" );
       $( "#custom-search-input" ).css( "height", "36px" );
    }

});