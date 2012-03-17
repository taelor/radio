task :deliver_morning_emails => :environment do
  current_episode = Episode.where(:air_datetime.gt => Date.today).last
  EpisodeMailer.schedule(current_episode).deliver
  
  Episode.where(:recording_datetime.gt => Date.today).reverse.each do |episode|
    EpisodeMailer.needed_items(episode).deliver
  end
end
