module Formtastic
  module Inputs
    class JustDatetimePickerInput
      include ::Formtastic::Inputs::Base

      def to_html
        input_wrapping do
          combined_value = builder.object.send(method)

          hour_value_raw = builder.object.send("#{method}_time_hour")
          if not hour_value_raw.nil?
            hour_value = hour_value_raw
          elsif not combined_value.nil?
            hour_value = combined_value.hour
          else
            hour_value = "00"
          end

          minute_value_raw = builder.object.send("#{method}_time_minute")
          if not minute_value_raw.nil?
            minute_value = minute_value_raw
          elsif not combined_value.nil?
            minute_value = combined_value.min
          else
            minute_value = "00"
          end

          hour_value   = sprintf("%02d", hour_value)
          minute_value = sprintf("%02d", minute_value)
          label_html <<
          builder.text_field("#{method}_date", input_html_options.merge({ :id => "#{builder.object.class.model_name.param_key}_#{method}", :class => "just-datetime-picker-field just-datetime-picker-date datepicker", :value => builder.object.send("#{method}_date"), :maxlength => 10, :size => 10 })) <<

          builder.number_field("#{method}_time_hour", input_html_options.merge({ :id => "#{builder.object.class.model_name.param_key}_#{method}_time_hour", :class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-hour", :value => hour_value, :maxlength => 2, :size => 2, min: 0, max: 23 })) <<
          ":" <<
          builder.number_field("#{method}_time_minute", input_html_options.merge({ :id => "#{builder.object.class.model_name.param_key}_#{method}_time_minute", :class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-minute", :value => minute_value, :maxlength => 2, :size => 2, min: 0, max: 59 }))
        end
      end
    end
  end
end
