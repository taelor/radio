class Conference < ActiveRecord::Base
  def to_s
    "#{name} (#{start_date.to_s(:short_date)} - #{end_date.to_s(:short_date)})"
  end
end
