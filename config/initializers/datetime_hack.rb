require 'active_record'

module CoHack
  module DatetimeHack
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def datetime_hack(*attributes)
        
        send :define_method, "combine_to_datetime".to_sym do |date_string, time_string|
          return nil if date_string.to_s.empty? or time_string.to_s.empty?  
          
          time_string = "00:00" if time_string == "0"
          
          time_string.insert(-3, ":") if time_string.length < 5 and time_string.length > 2
          time_string.squeeze!(":")
          
          if time_match = time_string.match(/^([0-9][0-9](\:)*[0-9][0-9])$/)
            hour, minutes  = time_match[0].split(":")
            
            return nil unless (hour.to_i >= 0 and hour.to_i < 24)
            return nil unless (minutes.to_i >= 0 and minutes.to_i <= 60)
          else
            return nil
          end
          
          ds = date_string.to_date
        end
        
        send :define_method, "is_valid_date?".to_sym do |field|
          date_string = send(field) #instance_variable_get("@#{field}")
          
          if date_string.to_s.empty?
            #do nothing, we're cool
          else
            date = date_string.to_date rescue nil

            if date.nil?
              errors.add(field, 'has an invalid date format, It must be in MM/DD/YYYY')
            end
          end
        end
        
        send :define_method, "is_valid_time?".to_sym do |field|
          time = send(field) #instance_variable_get("@#{field}")
          
          time = "00:00" if time == "0"
          
          time.insert(-3, ":") if time and time.length < 5 and time.length > 2
          time.squeeze!(":") if time
          
          if time.to_s.empty?
            # do nothing! it's cool!
          elsif time.match(/^([0-9][0-9](\:)*[0-9][0-9])$/)
            hour, minutes = time.split(":")
            
            errors.add(field, 'must be in valid 24 hour time, between 0000 and 2359') unless (hour.to_i >= 0 and hour.to_i < 24)
            
            errors.add(field, 'has an invalid number of minutes') unless (minutes.to_i >= 0 and minutes.to_i < 60)
          else
            errors.add(field, 'has an invalid time format, It must be in HHMM')
          end
        end
        
        attributes.each do |attribute|
          attribute_array = attribute.to_s.split("_")
          attribute_array.pop
          attribute_base = attribute_array.join("_")
          
          send :define_method, "#{attribute_base}_date=".to_sym do |date_value|
            instance_variable_set("@#{attribute_base}_date", date_value.to_date)
          end
          
          send :define_method, "#{attribute_base}_date".to_sym do
            date_value = instance_variable_get("@#{attribute_base}_date")
            if !date_value
              instance_variable_set("@#{attribute_base}_date", (self.send(attribute.to_sym).to_date rescue nil))
              date_value = instance_variable_get("@#{attribute_base}_date")
            end
            date_value
          end
          
          send :define_method, "#{attribute_base}_time=".to_sym do |time_value|
            instance_variable_set("@#{attribute_base}_time", time_value ) 
          end
          
          send :define_method, "#{attribute_base}_time".to_sym do
            time_value = instance_variable_get("@#{attribute_base}_time")
            if !time_value
              instance_variable_set("@#{attribute_base}_time", (self.send(attribute.to_sym).strftime("%H%M") rescue nil ))
              time_value = instance_variable_get("@#{attribute_base}_time")
            end
            time_value
          end
          
          send :define_method, "#{attribute_base}_time_is_valid_date?" do
            self.send("is_valid_date?".to_sym, "#{attribute_base}_date".to_sym)
          end
          
          send :define_method, "#{attribute_base}_time_is_valid_time?" do
            self.send("is_valid_time?".to_sym, "#{attribute_base}_time".to_sym)
          end
                    
          send :define_method, "combine_#{attribute}".to_sym do
            
            date_value = instance_variable_get("@#{attribute_base}_date")
            time_value = instance_variable_get("@#{attribute_base}_time")
            
            return if !(date_value or time_value)
            
            self.send("#{attribute}=".to_sym, combine_to_datetime(date_value, time_value))
          end

          self.class_eval do
            validate "#{attribute_base}_time_is_valid_date?"
            validate "#{attribute_base}_time_is_valid_time?"
            before_save "combine_#{attribute}"
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, CoHack::DatetimeHack
