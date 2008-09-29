xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "World Racketeering Squad lyrics"
    xml.description "Song lyrics of World Racketeering Squad, rock and roll pop band from Austin, Texas."
    xml.link formatted_lyrics_url(:rss)

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