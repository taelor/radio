class UserMailer < ActionMailer::Base
  default :from => "TechTalk@imi-us.com"
  
  def new_user_email(user, default_password)
    @user = user
    @default_password = default_password
    mail(:to => @user.email, :subject => "Welcome to IMI's Tech Talk")
  end
end
