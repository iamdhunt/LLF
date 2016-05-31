// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require js-routes
//= require swf_fu
//= require jquery.autosize.js
//= require soundmanager2-nodebug
//= require jquery.remotipart
//= require private_pub
//= require froala_editor.min.js
//= require plugins/lists.min.js
//= require plugins/fullscreen.min.js
//= require plugins/code_view.min.js
//= require plugins/align.min.js
//= require plugins/draggable.min.js
//= require plugins/code_beautifier.min.js
//= require jquery.atwho
//= require jquery.embedly.min.js
//= require jquery.preview.js
//= require selectize.js
//= require moment.min.js
//= require bootstrap-material-datetimepicker.js
//= require_tree .

// This is example code to set browser cookies. Assuming that your app uses jQuery and jquery-cookie libraries.
// These methods need to be there ideally on each page.

var browser_tz_baseline_year = 2011; //change this to 'current' if needed

var tz_baseline_year = function () {
  return (browser_tz_baseline_year.toString() === "current") ? new Date().getFullYear() : browser_tz_baseline_year.toString();
}

var set_browser_offsets = function () {
  var base_year = tz_baseline_year();
  var winterOffset = -1 * (new Date(base_year, 11, 21)).getTimezoneOffset() * 60;
  var summerOffset = -1 * (new Date(base_year, 5, 21)).getTimezoneOffset() * 60;
  $.cookie('utc_offset_summer', null, {path: '/'});
  $.cookie('utc_offset_winter', null, {path: '/'});
  $.cookie('utc_offset_summer', summerOffset, {path: '/'});
  $.cookie('utc_offset_winter', winterOffset, {path: '/'});
}

$(document).ready(function () {
  set_browser_offsets();
});

$(document).ajaxStart(function () {
  set_browser_offsets();
});

window.onbeforeunload = function() {
  set_browser_offsets();
};