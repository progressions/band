class Blog < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"
  has_many :comments, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy
  
  has_friendly_id :title, :use_slug => true
  
  # TODO: Allow tagging of blog posts by the poster
  
  validates_presence_of :title, :body
    
  def subscribe email
    sub = self.subscriptions.find_or_create_by_email(email)
    sub.save
  end
  
  def unsubscribe email
    sub = subscribed(email)
    sub.destroy unless sub.nil?
  end
  
  def subscribed email
    self.subscriptions.find_by_email(email)
  end
end
