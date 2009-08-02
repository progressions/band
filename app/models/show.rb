class Show < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"
  belongs_to :venue
  belongs_to :report, :class_name => "ShowReport"
  has_many :ratings, :class_name => "ShowRating"
  
  validates_presence_of :date, :venue

  named_scope :created_since, lambda {|since_date| {:conditions => ["created_at >= ?", since_date]}}
  named_scope :performed_since, lambda {|since_date| {:conditions => ["date >= ?", since_date]}}
  
  def self.most_recent
    scoped(:conditions => ["date < ?", Time.now], :order => "date DESC").first
  end
  
  def has_rsvp?
    facebook_event? || myspace_event?
  end
  
  def facebook_event?
    !facebook_event.blank?
  end
  
  def myspace_event?
    !myspace_event.blank?
  end
  
  def notes?
    !notes.blank?
  end
end
