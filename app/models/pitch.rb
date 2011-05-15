class Pitch < ActiveRecord::Base
  belongs_to :guest, :class_name => "User"
  belongs_to :contact, :class_name => "User"
  
  accepts_nested_attributes_for :guest,
    :reject_if => proc { |attributes| attributes['first_name'].blank? or attributes['email'].blank? }
      
  accepts_nested_attributes_for :contact,
    :reject_if => proc { |attributes| attributes['first_name'].blank? or attributes['email'].blank? }
    
  def to_s
    title
  end
end
