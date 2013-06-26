module EpisodesHelper
  def wordpress_content(resource)
    content = ""
    if resource.audio_link.present?
      content += "[audio #{resource.audio_link}]\n\n"
      content += "<a href='#{resource.audio_link}'>Right click to download</a>\n\n"
    end
    content += "#{resource.description}\n\n"
    content += "#{resource.guest.bio}\n\n" if resource.guest and resource.guest.bio.present?
    content += "<h3>Week In Review</h3>\n\n"
    content += "<hr>\n\n"
    content += "<ol id='stories'>\n"
    resource.stories.each do |story|
      content += "\t\t<li><a href='#{story.url}'>#{story.title}</a></li>\n"
    end
    content += "</ol>"
  end
end