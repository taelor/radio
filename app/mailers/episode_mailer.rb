class EpisodeMailer < RadioMailer  
  def schedule(episode)
    @episode = episode
    mail(:to =>"thredden@gmail.com", :subject => "IMI's TechTalk - Schedule - #{@episode.recording_description}")
  end
  
  def script(episode)
    @episode = episode
    attachments[@episode.script_name] = WickedPdf.new.pdf_from_string(
      render_to_string(
        :template => 'episodes/script',
        :layout => false, 
        :header => {
          :left => "#{@episode.live? ? 'LIVE': 'PRERECORD'} - #{@episode.recording_datetime.to_date.to_s(:short)}",
          :center => "Guest: #{@episode.guest_name}",
          :right => "TECHTALK"
        },
        :footer => {
          :left => "IMI Group",
          :center => 'Page [page]/[topage]'
        }            
      )
    )
    mail(:to =>"thredden@gmail.com", :subject => "IMI's TechTalk - Script- #{@episode.title} - #{@episode.recording_description}") do |format|
      format.text
      format.html
    end
  end
  
  def needed_items(episode)
    @episode = episode
    mail(:to =>"thredden@gmail.com", :subject => "IMI's TechTalk - Needed Items - #{@episode.title}")
  end
end
