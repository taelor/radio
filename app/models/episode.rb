class Episode < ActiveRecord::Base
  belongs_to :guest, :class_name => "User"
  belongs_to :host, :class_name => "User"

  has_many :stories
  has_many :questions

  accepts_nested_attributes_for :stories,
      :reject_if => proc { |attributes| attributes['title'].blank? }
      
  accepts_nested_attributes_for :questions,
    :reject_if => proc { |attributes| attributes['body'].blank? }
    
  default_scope :order => 'air_datetime DESC'
  
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
  
  def next
    Episode.where(["air_datetime > ?", self.air_datetime ]).first
  end
  
  def to_s
    title
  end
end
