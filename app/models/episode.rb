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
  
  def guest_name
    guest ? guest.full_name : "None"
  end
  
  def shortened_title
    shortened_title = title.size > 30 ? "#{title[0..27]}..." : title 
    "#{air_datetime.to_date} - #{shortened_title}"
  end
end
