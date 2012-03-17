#times
Time::DATE_FORMATS[:radio] = "%A %B %d, %Y at %I:%M %p"

#dates
Date::DATE_FORMATS[:short_date] = "%m/%d/%Y"


Date::DATE_FORMATS.merge!(
  :default => '%m/%d/%Y',
  :date_time12  => "%m/%d/%Y %I:%M %p",
  :date_time24  => "%m/%d/%Y %H:%M"
)

Time::DATE_FORMATS.merge!(
  :default  => "%m/%d/%Y %I:%M %p",
  :time_12 => "%I:%M %p",
  :time_24 => "%m/%d/%Y %H%M",
  :time_text_field => "%H%M"
)
