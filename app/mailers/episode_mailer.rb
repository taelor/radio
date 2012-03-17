class EpisodeMailer < RadioMailer  
  def schedule(episode)
    @episode = episode
    mail(:to =>"thredden@gmail.com", :subject => "IMI's TechTalk - Schedule - #{@episode.recording_description}")
  end
  
  def script(episode)
    @episode = episode
    
    attachments["script.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(:pdf => "script", :template => 'episodes/script')
    )
          
    self.instance_variable_set(:@lookup_context, nil)
    mail(:to =>"thredden@gmail.com", :subject => "IMI's TechTalk - Script- #{@episode.title} - #{@episode.recording_description}")
  end
  
  def needed_items(episode)
    @episode = episode
    mail(:to =>"thredden@gmail.com", :subject => "IMI's TechTalk - Needed Items - #{@episode.title}")
  end
end
