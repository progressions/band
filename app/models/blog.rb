class Blog < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"
  has_many :comments, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy
  
  # has_friendly_id :title, :use_slug => true
  
  # TODO: Allow tagging of blog posts by the poster
  
  validates_presence_of :title, :body

  scope :created_since, lambda {|since_date| {:conditions => ["created_at >= ?", since_date]}}
  scope :posted_since, lambda {|since_date| {:conditions => ["posted_at >= ?", since_date]}}
  scope :active, {:conditions => {:active => true}}
  scope :hidden, {:conditions => {:active => false}}
  scope :posted_yet, lambda {
    {
      :conditions => ["posted_at < ?", Time.now],
      :order => "posted_at DESC, created_at DESC"
    }
  }
  
  def posted_yet?
    posted_at < Time.now
  end
  
  def posted_at
    read_attribute(:posted_at) || read_attribute(:created_at)
  end
  
  def hidden?
    !active?
  end
    
  def subscribe(email)
    sub = self.subscriptions.find_or_create_by_email(email)
    sub.save
  end
  
  def unsubscribe(email)
    sub = subscribed(email)
    sub.destroy unless sub.nil?
  end
  
  def subscribed(email)
    self.subscriptions.find_by_email(email)
  end
end
