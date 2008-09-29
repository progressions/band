xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "World Racketeering Squad blog comments"
    xml.description "Comments on the official blog of World Racketeering Squad, rock and roll pop band from Austin, Texas."
    xml.link formatted_comments_url(:rss)

    for comment in @comments
      xml.item do
        xml.title "Comment on '#{comment.blog.title}'"
        xml.description comment.body
        xml.author "comment.user.email (#{comment.name})"
        xml.pubDate comment.created_at.to_s(:rfc822)
        xml.link blog_url(comment.blog)
        xml.guid blog_url(comment.blog)
      end
    end
  end
end