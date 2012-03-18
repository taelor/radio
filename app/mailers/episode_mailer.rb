class EpisodeMailer < RadioMailer
  def schedule(episode)
    @episode = episode
    mail(:to => @episode.email_recipients, :subject => "IMI's TechTalk - Schedule - #{@episode.recording_description}")
  end

  def script(episode)
    @episode = episode
    subject = "IMI's TechTalk - Script- #{@episode.title} - #{@episode.recording_description}"
    
    attachments["#{@episode.script_name}.pdf"] = File.read(Rails.root.join('tmp', "#{@episode.script_name}.pdf"))
    
    mail(:to => @episode.email_recipients, :subject => subject)
  end

  def needed_items(episode)
    @episode = episode
    mail(:to => [@episode.guest, "TechTalk@imi-us.com"], :subject => "IMI's TechTalk - Needed Items - #{@episode.title}")
  end
end
