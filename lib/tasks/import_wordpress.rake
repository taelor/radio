desc "Imports imitechtalk.com from tech talk workbook archive"

task :import_workbook => :environment do 
  guest_role = Role.find_by_name("Guest")
  
  episode_number = 1
  File.open("#{Rails.root}/tmp/techtalk_workbook_archive.csv").readlines.each { |line|
    date_string, guest_string, title = line.split("\t")
    
    date = date_string.to_date
    
    guest_array = guest_string.split(" ")
    first_name = guest_array.first
    last_name = guest_array.last
    
    title = title.gsub('"', '').gsub("\u201C", '').gsub("\u201D", '')
    
    puts title
    
    guest = User.find_by_first_name_and_last_name(first_name, last_name)
    if guest.nil?
      guest = User.create(
        first_name: first_name,
        last_name: last_name,
        role_id: guest_role.id
      )
    end
    
    episode = Episode.new
    episode.title = title.strip
    episode.air_datetime = (date + 18.hours).to_datetime
    episode.guest = guest
    episode.episode_number = episode_number
    episode.save
    
    episode_number += 1
  }.count
  
end

desc "Imports imitechtalk.com from wordpress"

task :import_wordpress => :environment do  
  xml_document = File.open("#{Rails.root}/tmp/imitechtalk.wordpress.2012-04-07.xml")
  doc = Nokogiri::XML(xml_document)
  
  module WpxmlParser
    class Blog  
      def posts
        @xml.xpath('//item').map do |item|
          Post.new(item)
        end.select{|p| (p.post_type == 'page' || p.post_type == "post") && p.status == 'publish'}
      end
    end
  end

  posts = Blog.new(xml_document).posts.sort{|a,b| a.date.to_date <=> b.date.to_date}
  
  posts.each { |post|
    title = post.title
    audio_link = post.body.match(/href\=\"(http\:\/\/.*TechTalk\.mp3)/i).try(:[], -1)
    
    date = if (audio_link.split("/").last.to_date rescue nil).try(:sunday?)
      audio_link.split("/").last.to_date
    elsif post.date.to_date.try(:sunday?)
      post.date.to_date
    elsif (title.to_date rescue nil).try(:sunday?)
      title.to_date
    else
      nil
    end    
    
    if date.nil?
      puts post.title
      puts "#{date} - #{!!date.try(:sunday?)}"
      puts audio_link
      puts post.body
      puts
    else
      if episode = Episode.where(:air_datetime => date.to_datetime..(date.to_datetime + 23.hours + 59.minutes)).first
        puts post.title
        puts post.body
        episode.audio_link ||= audio_link
        episode.description = episode.description.to_s.empty? ? post.body : episode.description
        episode.save
      else
        if date.sunday?
          episode = Episode.create(
            title: title,
            air_datetime: date.to_datetime+18.hours,
            audio_link: audio_link
          )
        end
      end
    end
  }.count
    
  
  
end