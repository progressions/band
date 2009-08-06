xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@global_settings.artist_name} blog"
    xml.description "The official blog of #{@global_settings.artist_name}."
    xml.link blogs_url(:format => :rss)

    for blog in @blogs
      xml.item do
        xml.title blog.title
        xml.description blog.body
        xml.author blog.user.email
        xml.pubDate blog.created_at.to_s(:rfc822)
        xml.link blog_url(blog)
        xml.guid blog_url(blog)
      end
    end
  end
end