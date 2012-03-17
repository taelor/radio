class DatePickerInput
  include Formtastic::Inputs::Base
    
  def to_html
    input_wrapping do
      label_html <<
      builder.text_field(method, input_html_options)
    end
  end
  
  def input_html_options
    super.merge( {:class => 'datepicker' })
  end
end


=begin
module Formtastic
  module DatePicker
    protected
    
    def date_picker_input(method, options = {})
      format = options[:format] || Date::DATE_FORMATS[:default] || '%m/%d/%Y'
      string_input(method, datepicker_options(format, object.send(method)).merge(options))
    end
 
    def datetime_picker_input(method, options = {})
      date_method = method.to_s.split("_")[0]+"_date"
      time_method = method.to_s.split("_")[0]+"_time"
      format = options[:format] || Date::DATE_FORMATS[:default] || '%m/%d/%Y'
      string_input(date_method, datepicker_options(format, object.send(method)).merge(options)) + 
        string_input(time_method, {})
    end
    
    # Generate html input options for the datepicker_input
    #
    def datepicker_options(format, value = nil)
      datepicker_options = {:input_html => {:class => 'datepicker', :value => value.try(:strftime, format)}}
    end
  end
end
Formtastic::FormBuilder.send(:include, Formtastic::DatePicker)
=end