xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "World Racketeering Squad Unified RSS"
    xml.description "The official RSS feed of World Racketeering Squad, rock and roll pop band from Austin, Texas.  This feed includes blogs, news and lyrics."
    
    xml.link "http://www.worldracketeeringsquad.com/rss.rss"

    for @item in @items
      xml.item do        
        if @item.is_a?(YouTube::Video)
          item_class_name = "VIDEO"
        elsif @item.is_a?(Entry)
          item_class_name = "NEWS"
        else
          item_class_name = @item.class.to_s.upcase
        end
        
        xml.title "#{item_class_name}: #{@item.title}"
        xml.description sanitize(@item.body)
        xml << "<content:encoded xmlns:content='http://purl.org/rss/1.0/modules/content/'><![CDATA[#{@item.body}]]></content:encoded>"
        xml.author "#{@item.user.email} (#{@item.user.full_name})"
        xml.pubDate @item.created_at.to_s(:rfc822)
        if @item.is_a?(YouTube::Video)
          xml.link @item.link
          xml.guid @item.link
        else
          xml.link eval("#{@item.class.to_s.downcase}_url(@item)")
          xml.guid eval("#{@item.class.to_s.downcase}_url(@item)")
        end
      end
    end
  end
end