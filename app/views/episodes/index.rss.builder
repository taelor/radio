author = "IMI"
show_description = "Weekly show featuring guest interviews on various topics, and a review of the lastest news in technology."

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd" do
  xml.channel do
    xml.title "IMI's Tech Talk"
    xml.description show_description
    xml.link "http://imitechtalk.com"
    xml.language "en-us"
    xml.copyright "&#x2117; &amp; &#xA9; Information Methods Incorporated"
    
    xml.itunes :summary, show_description
    xml.itunes :subtitle, "Educating the masses one byte at a time."
    xml.itunes :author, author
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, "techtalk@imi-us.com"
    end
    xml.itunes :category, text: "Technology"
    xml.itunes :image, href: "https://imitechtalk.files.wordpress.com/2012/04/logo.png"
    
    @episodes.have_audio.each do |episode|
      xml.item do
        xml.title episode.title
        xml.description episode.description
        
        xml.itunes :author, author
        
        xml.itunes :subtitle, ""
        
        xml.itunes :summary, episode.description
        
        xml.itunes :image, href: "https://imitechtalk.files.wordpress.com/2012/04/logo.png"
        
        xml.enclosure url: episode.audio_link
        
        xml.guid episode.id
        
        xml.pubdate episode.air_datetime.rfc2822
        
        xml.itunes :duration, episode.duration
        
        xml.keywords "technology"
        
      end
    end
  end
end