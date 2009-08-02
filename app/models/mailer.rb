class Mailer < ActionMailer::Base  
  def signup_confirmation fan
    recipients  fan.email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[#{global_settings.mail_tag}] Thank you for joining the #{global_settings.artist_name} mailing list!"
    body        :fan => fan, :global_settings => global_settings
    content_type "text/html" 
  end
  
  def signup_report fan
    recipients  global_settings.admin_email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[New fan] #{fan.email} has joined the mailing list!"
    body        :fan => fan, :global_settings => global_settings
    content_type "text/html"
  end
  
  def unsubscribe_report fan
    recipients  global_settings.admin_email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[Unsubscribed] #{fan.email} has unsubscribed from the mailing list!"
    body        :fan => fan, :global_settings => global_settings
    content_type "text/html"
  end
  
  def comment_notification user, blog, comment
    recipients  user.email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[New comment] #{comment.name} has commented on your blog posting '#{blog.title}'"
    body        :user => user, :blog => blog, :comment => comment, :global_settings => global_settings
    content_type "text/html"
  end
  
  def comment_subscription email, blog, comment
    recipients  email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[New comment] #{comment.name} has commented on the blog posting '#{blog.title}'"
    body        :email => email, :blog => blog, :comment => comment, :global_settings => global_settings
    content_type "text/html"
  end
    
  def mail fan, mail
    recipients  fan.email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[#{global_settings.mail_tag}] #{mail.title}"
    body        :fan => fan, :mail => mail, :global_settings => global_settings
    content_type "text/html"
  end
  
  def status_report
    recipients  global_settings.admin_email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[#{mail_tag}] Status Report"
    body        :global_settings => global_settings
    content_type  "text/html"
  end
  
  protected
  
  def global_settings
    Setting.find(1)
  end
  
  def mail_tag
    global_settings.mail_tag
  end
end
