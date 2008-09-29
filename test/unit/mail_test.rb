require File.dirname(__FILE__) + '/../test_helper'

class MailTest < ActiveSupport::TestCase
  fixtures :mails
  
  def test_invalid_with_empty_attributes
    mail = Mail.new
    assert !mail.valid?
    assert mail.errors.invalid?(:title)
    assert mail.errors.invalid?(:body)
  end
  
  def test_invalid_without_title
    mail = Mail.new(:body => "Hey this is a mail")
    assert !mail.valid?
    assert mail.errors.invalid?(:title)
  end
  
  def test_invalid_without_body
    mail = Mail.new(:title => "A mail")
    assert !mail.valid?
    assert mail.errors.invalid?(:body)
  end
  
  def test_valid_mail    
    mail = mails(:one)
    assert mail.valid?
  end
  
  def test_delete
    count = Mail.count
    mail = mails(:one)
    mail.destroy
    assert_equal count-1, Mail.count
  end
  
  def test_update
    new_title = "A New Title"
    new_body = "This is a different mail"
    mail = mails(:one)
    mail.update_attributes(:title => new_title, :body => new_body)
    assert_equal new_title, mail.title
    assert_equal new_body, mail.body
  end
end