xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@global_settings.artist_name} lyrics"
    xml.description "Song lyrics of #{@global_settings.artist_name}."
    xml.link lyrics_url(:format => :rss)

    for lyric in @lyrics
      xml.item do
        xml.title lyric.title
        xml.description simple_format(lyric.body)
        xml.author lyric.user.email
        xml.pubDate lyric.created_at.to_s(:rfc822)
        xml.link lyric_url(lyric)
        xml.guid lyric_url(lyric)
      end
    end
  end
end