class Mailer < ActionMailer::Base  
  layout 'email_layout'
  
  def signup_confirmation fan
    recipients  fan.email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[#{global_settings.mail_tag}] Thank you for joining the #{global_settings.artist_name} mailing list!"
    body        :fan => fan, :global_settings => global_settings, :title => "Thank you for joining the #{global_settings.artist_name} mailing list!"
    content_type "text/html" 
  end
  
  def signup_report fan
    recipients  global_settings.admin_email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[New fan] #{fan.email} has joined the mailing list!"
    body        :fan => fan, :global_settings => global_settings, :title => "#{fan.email} has joined the mailing list!"
    content_type "text/html"
  end
  
  def unsubscribe_report fan
    recipients  global_settings.admin_email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[Unsubscribed] #{fan.email} has unsubscribed from the mailing list!"
    body        :fan => fan, :global_settings => global_settings, :title => "#{fan.email} has unsubscribed from the mailing list!"
    content_type "text/html"
  end
  
  def comment_notification user, blog, comment
    recipients  user.email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[New comment] #{comment.name} has commented on your blog posting '#{blog.title}'"
    body        :user => user, :blog => blog, :comment => comment, :global_settings => global_settings, :title => "#{comment.name} has commented on your blog posting '#{blog.title}'"
    content_type "text/html"
  end
  
  def comment_subscription email, blog, comment
    recipients  email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[New comment] #{comment.name} has commented on the blog posting '#{blog.title}'"
    body        :email => email, :blog => blog, :comment => comment, :global_settings => global_settings, :title => "#{comment.name} has commented on the blog posting '#{blog.title}'"
    content_type "text/html"
  end
    
  def mail fan, mail
    recipients  fan.email
    from        "#{global_settings.artist_name} <#{global_settings.email}>"
    subject     "[#{global_settings.mail_tag}] #{mail.title}"
    body        :fan => fan, :mail => mail, :global_settings => global_settings, :shows => Show.upcoming, :blogs => Blog.active.posted_yet.find(:all, :limit => 3, :order => "posted_at DESC, created_at DESC"), :title => mail.title
    content_type "text/html"
  end
  
  def status_report(status_presenter)
    recipients  status_presenter.site.admin_email
    from        "#{status_presenter.site.artist_name} <#{status_presenter.site.email}>"
    subject     "[#{mail_tag}] Status Report for #{status_presenter.to_date}"
    body        :status_presenter => status_presenter, :title => "Status Report for #{status_presenter.to_date}"
    content_type  "text/html"
  end
  
  protected
  
  def global_settings
    Setting.first
  end
  
  def mail_tag
    global_settings.mail_tag
  end
end
