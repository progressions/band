xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "World Racketeering Squad News"
    xml.description "The official news feed of World Racketeering Squad, rock and roll pop band from Austin, Texas."
    xml.link formatted_entries_url(:rss)

    for entry in @entries
      xml.item do
        xml.title entry.title
        xml.description entry.body
        xml.author entry.user.email
        xml.pubDate entry.created_at.to_s(:rfc822)
        xml.link entry_url(entry)
        xml.guid entry_url(entry)
      end
    end
  end
end