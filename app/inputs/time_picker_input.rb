class TimePickerInput
  include Formtastic::Inputs::Base
    
  def to_html
    input_wrapping do
      label_html <<
      builder.text_field(method, input_html_options)
    end
  end
  
  def input_html_options
    super.merge( {:class => 'timepicker' })
  end  
end
