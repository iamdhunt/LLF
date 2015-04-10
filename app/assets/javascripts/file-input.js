$(document).on('change', '#file-upload', function() {
  $('i', '.fu1_wrap').removeClass("fa-arrow-up");
  $('i', '.fu1_wrap').addClass("fa-check");
  $('label[for="file-upload"]', '.fu1_wrap').css("background-color", '#3fa46a');
});

$(document).on('change', '#file-upload2', function() {
  $('i', '.fu2_wrap').removeClass("fa-arrow-up");
  $('i', '.fu2_wrap').addClass("fa-check");
  $('label[for="file-upload2"]', '.fu2_wrap').css("background-color", '#3fa46a');
});

$(document).on('change', '#file-upload3', function() {
  $('i', '.fu3_wrap').removeClass("fa-arrow-up");
  $('i', '.fu3_wrap').addClass("fa-check");
  $('label[for="file-upload3"]', '.fu3_wrap').css("background-color", '#3fa46a');
});