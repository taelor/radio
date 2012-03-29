namespace :radio do
  task :change_development_passwords => :environment do
    exit if Rails.env == "production"
    "Changing all users passwords to the same developement default:\n\n"
    User.all.each do |user|
      puts "Changing #{user} password"
      user.password = "hackme123"
      user.password_confirmation = "hackme123"
      user.save
    end
    "Users passwords have been changed."
  end
end
