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
       $( "#custom-search-input input" ).css( "width", "80%" );
       $( ".nav_search.l_o #custom-search-input" ).css( "margin-left", "320px" );
       $( ".nav_search #custom-search-input" ).css( "margin-left", "320px" );
       $( "#faqs_wrap" ).css( "padding-left", "1%" );
       $( "#faqs_wrap" ).css( "padding-right", "1%" );
       $( "#custom-search-input input" ).css( "font-size", "1em" );
       $( "#edit_wrap #when .input-group-addon" ).css( "padding", "6px 0 6px 0" );
       $( "#banner" ).css( "background-attachment", "inherit" );
    }

});