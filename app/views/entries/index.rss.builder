xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@global_settings.artist_name} News"
    xml.description "The official news feed of #{@global_settings.artist_name}."
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