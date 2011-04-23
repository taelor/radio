class EpisodeMailer < ActionMailer::Base
  default :from => "TechTalk@imi-us.com"
  
  def test_email()
    mail(:to =>"thredden@gmail.com", :subject => "Welcome to My Awesome Site")
  end
end
