class Pitch < ActiveRecord::Base
  
  after_create :send_new_pitch_notification
  
  default_scope :order => 'created_at DESC'
    
  def to_s
    title
  end
  
  protected
    
    def send_new_pitch_notification
      PitchMailer.new_pitch_email(self).deliver
    end
end
