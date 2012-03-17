class EpisodeMailer < RadioMailer  
  def schedule(episode)
    @episode = episode
    mail(:to =>"thredden@gmail.com", :subject => "IMI's TechTalk - Schedule - #{@episode.recording_description}")
  end

=begin
  
  def script(episode, pdf)
    @episode = episode
    attachments[@episode.script_name] = pdf
    self.instance_variable_set(:@lookup_context, nil)
    mail(:to =>"thredden@gmail.com", :subject => "IMI's TechTalk - Script- #{@episode.title} - #{@episode.recording_description}")
  end

=end

  def script(episode)
    @episode = episode
    subject = "IMI's TechTalk - Script- #{@episode.title} - #{@episode.recording_description}"
    
    attachments["#{@episode.script_name}.pdf"] = File.read(Rails.root.join('tmp', "#{@episode.script_name}.pdf"))
    
    mail(:to =>"thredden@gmail.com", :subject => subject)
  end

  def needed_items(episode)
    @episode = episode
    mail(:to =>"thredden@gmail.com", :subject => "IMI's TechTalk - Needed Items - #{@episode.title}")
  end
end
