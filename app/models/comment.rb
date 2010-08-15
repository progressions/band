class Comment < ActiveRecord::Base
  belongs_to :blog
  
  validates_presence_of :name, :email, :body
  # validates_email_veracity_of :email, :message => "Email is invalid"
end
