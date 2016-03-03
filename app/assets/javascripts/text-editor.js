$(document).ready(function() {

   $('#p_update').froalaEditor({
      key: 'ObE5A-8E1tA2wz==',
      inlineMode: false,
      placeholderText: 'Tell us about your update...',
      heightMin: 100,
      heightMax: 250,
      toolbarButtons: ['undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'formatUL', 'formatOL', 'outdent', 'indent', '|', 'html'],
      toolbarButtonsMD: ['undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'formatUL', 'formatOL', 'outdent', 'indent', '|', 'html'],
      toolbarButtonsSM: ['undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'formatUL', 'formatOL', 'outdent', 'indent'],
      toolbarButtonsXS: ['undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'formatUL', 'formatOL', 'outdent', 'indent']
    });

   $('#p_about').froalaEditor({
      key: 'ObE5A-8E1tA2wz==', 
      inlineMode: false,
      placeholderText: 'Now the long version...',
      heightMin: 100,
      toolbarButtons: ['undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'formatUL', 'formatOL', 'outdent', 'indent', '|', 'fullscreen', 'html'],
      toolbarButtonsMD: ['undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'formatUL', 'formatOL', 'outdent', 'indent', '|', 'fullscreen', 'html'],
      toolbarButtonsSM: ['undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'formatUL', 'formatOL', 'outdent', 'indent'],
      toolbarButtonsXS: ['undo', 'redo', '|', 'bold', 'italic', 'underline', '|', 'formatUL', 'formatOL', 'outdent', 'indent']
    });

});
