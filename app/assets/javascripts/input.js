$(document).ready(function(){

      $('.cat_select').selectize();

      $('.custom-tags').selectize({
            plugins: ['remove_button'],
            delimiter: ',',
            persist: false,
            create: function(input) {
                  return {
                        value: input,
                        text: input
                  }
            }
      });

      $('#event_start_date').bootstrapMaterialDatePicker({
            format: 'YY-MM-DD',
            time: false
      });

      $('#event_end_date').bootstrapMaterialDatePicker({
            format: 'YY-MM-DD',
            time: false
      });

      $('#event_start_time').bootstrapMaterialDatePicker({ 
            format: 'hh:mm A',
            date: false,
            shortTime: true,
            okText: 'Next',
            cancelText: 'Back'
      });

      $('#event_end_time').bootstrapMaterialDatePicker({ 
            format: 'hh:mm A',
            date: false,
            shortTime: true,
            okText: 'Next',
            cancelText: 'Back'
      });


});