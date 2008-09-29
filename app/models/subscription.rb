class Subscription < ActiveRecord::Base
  belongs_to :blog
  
  validates_uniqueness_of :blog_id, :scope => :email
  validates_uniqueness_of :email, :scope => :blog_id
	validates_email_veracity_of :email, :message => "Email is invalid"
end
