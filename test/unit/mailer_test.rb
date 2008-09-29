require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../vendor/rails/actionpack/lib/action_view/helpers/sanitize_helper'

# use "sanitize" to test the mailer views
include ActionView::Helpers::SanitizeHelper

class MailerTest < ActionMailer::TestCase
  fixtures :users, :blogs, :comments, :fans, :mails, :settings
  
  def test_signup_confirmation
    fan = fans(:one)
    assert_not_nil fan
    
    response = Mailer.deliver_signup_confirmation(fan)
    assert_match /#{fan.email} has subscribed to the #{settings(:one).artist_name} mailing list./, response.body
    
    assert_equal fan.email, response.to[0]
  end
  
  def test_signup_report
    fan = fans(:one)
    assert_not_nil fan
    
    response = Mailer.deliver_signup_report(fan)
    assert_not_nil response
    assert_match /New fan signup/, response.body
    assert_match /#{fan.email} has subscribed to the #{settings(:one).artist_name} mailing list./, response.body
    
    assert_equal settings(:one).admin_email, response.to[0]
  end
  
  def test_unsubscribe_report
    fan = fans(:one)
    assert_not_nil fan
    
    response = Mailer.deliver_unsubscribe_report(fan)
    assert_not_nil response
    assert_match /Fan unsubscribed/, response.body
    assert_match /#{fan.email} has unsubscribed from the #{settings(:one).artist_name} mailing list./, response.body
    
    assert_equal settings(:one).admin_email, response.to[0]
  end
  
  def test_comment_notification
    comment = comments(:one)
    blog = comment.blog
    user = blog.user
    
    assert_not_nil comment
    assert_not_nil blog
    assert_not_nil user
    
    response = Mailer.deliver_comment_notification(user, blog, comment)
    assert_match /#{sanitize(comment.name)}/, response.body
    assert_match /has left a comment on your blog/, response.body
    assert_match /#{sanitize(comment.blog.title)}/, response.body
    
    assert_equal user.email, response.to[0]
  end
  
  def test_comment_subscription
    comment = comments(:one)
    blog = comment.blog
    email = comments(:two).email
    
    assert_not_nil comment
    assert_not_nil blog
    assert_not_nil email
    
    response = Mailer.deliver_comment_subscription(email, blog, comment)
    assert_match /#{sanitize(comment.name)}/, response.body
    assert_match /has left a comment on the blog/, response.body
    assert_match /#{sanitize(comment.blog.title)}/, response.body
    
    assert_equal email, response.to[0]
  end
  
  def test_mail
    fan = fans(:one)
    mail = mails(:one)
    assert_not_nil fan
    assert_not_nil mail
    
    response = Mailer.deliver_mail(fan, mail)
    assert_match mail.body, response.body
    
    assert_equal fan.email, response.to[0]
  end
end