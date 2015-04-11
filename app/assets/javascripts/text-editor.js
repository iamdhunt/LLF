$(document).ready(function() {

   $('#p_update').editable({
      inlineMode: false,
      placeholder: 'Tell us about your update...',
      minHeight: 100,
      maxHeight: 250,
      buttons: ['bold', 'italic', 'underline', 'insertUnorderedList', 'insertOrderedList', 'undo', 'redo', 'html']
    });

   $('#p_about').editable({
      inlineMode: false,
      placeholder: 'Now the long version...',
      minHeight: 100,
      buttons: ['bold', 'italic', 'underline', 'insertUnorderedList', 'insertOrderedList', 'undo', 'redo', 'html']
    });

});
