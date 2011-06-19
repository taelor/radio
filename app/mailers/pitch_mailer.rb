class PitchMailer < ActionMailer::Base
  default :from => "TechTalk@imi-us.com"
  
  def new_pitch_email(pitch)
    @pitch = pitch
    mail(:to => "TechTalk@imi-us.com", :subject => "New Pitch - #{pitch.title}")
  end
end
