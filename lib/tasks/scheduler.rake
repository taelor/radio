desc "This task is called by the Heroku scheduler add-on"
task :deliver_morning_emails => :environment do  
  if Date.today.monday?
    current_episode = Episode.where(:air_datetime.gt => Date.today).last
    puts "Delivering This week's schedule"
    puts EpisodeMailer.schedule(current_episode).deliver
  
    Episode.where(:recording_datetime.gt => Date.today).reverse.each do |episode|
      puts EpisodeMailer.needed_items(episode).deliver
    end
  end
end