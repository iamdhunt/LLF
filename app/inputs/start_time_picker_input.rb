## app/inputs/start_time_picker_input.rb
class StartTimePickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:div, class: 'input-group time form_datetime') do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat span_table
    end
  end

  def input_html_options
    super.merge({class: 'form-control', id: 'event_start_time', readonly: true, placeholder: "Start Time"})
  end

  def span_table
    template.content_tag(:span, class: 'input-group-addon') do
      template.concat icon_table
    end
  end

  def icon_table
    "<i class='fa fa-clock-o'></i>".html_safe
  end

end