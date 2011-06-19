class Pitch < ActiveRecord::Base
  
  default_scope :order => 'created_at DESC'
    
  def to_s
    title
  end
end
