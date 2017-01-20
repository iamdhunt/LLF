$(document).ready(function(){

      var tz = jstz.determine();
      tz.name(); // returns "America/Los Angeles"

      jQuery(function() {
        var tz = jstz.determine();
        Cookies.set('timezone', tz.name(), { expires: 365, path: '/' });
      });

});