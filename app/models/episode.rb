class Episode < ActiveRecord::Base
  
  datetime_hack :recording_datetime, :air_datetime
  
  belongs_to :guest, :class_name => "User"
  belongs_to :host, :class_name => "User"

  has_many :stories
  has_many :questions

  accepts_nested_attributes_for :stories,
      :reject_if => proc { |attributes| attributes['title'].blank? }
      
  accepts_nested_attributes_for :questions,
    :reject_if => proc { |attributes| attributes['body'].blank? }
    
  default_scope :order => 'air_datetime DESC'
  
  def script_name
    "#{air_datetime.strftime('%Y%m%d')} TechTalk Script - #{live? ? 'LIVE' : 'PRERECORD'} - #{guest_name} - #{recording_datetime.strftime('%B %e at%l %p ET')}"
  end
  
  def title
    if attributes["title"].to_s.empty?
      "(Title Needed)"
    else
      attributes["title"]
    end
  end
  
  def guest_name
    guest ? guest.full_name : "None"
  end
  
  def shortened_title
    the_title = title.size > 30 ? "#{title[0..27]}..." : title 
    "#{air_datetime.to_date} - #{the_title}"
  end
  
  def publicists
    guest.publicists
  end
  
  def week_of_month
    air_date = air_datetime.to_date
    count = 0
    
    air_date.downto(Date.new(air_date.year, air_date.month, 1)) do |increment_date|
      count += 1 if increment_date.wday == 0
    end
    count.ordinalize
  end
  
  def next
    Episode.unscoped.where(["air_datetime > ?", self.air_datetime ]).order("air_datetime ASC").first
  end

  def live?
    air_datetime == recording_datetime
  end
  
  def prerecord?
    !live?
  end
  
  def to_s
    title
  end
end
