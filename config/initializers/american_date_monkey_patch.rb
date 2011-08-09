if RUBY_VERSION >= '1.9'
  class String
    def to_date
      if self.blank?
        nil
      elsif self =~ /(\d{1,2})\/(\d{1,2})\/(\d{4})/
        ::Date.civil($3.to_i, $1.to_i, $2.to_i)
      else
        ::Date.new(*::Date._parse(self, false).values_at(:year, :mon, :mday))
      end
    end
  end
  class ActiveRecord::ConnectionAdapters::Column
    def self.fallback_string_to_date(string)
      string.to_date
    end
  end
end