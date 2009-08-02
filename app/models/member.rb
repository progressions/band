class Member < ActiveRecord::Base
  belongs_to :setting
  validates_presence_of :name, :url, :active
  validates_uniqueness_of :url
  validates_length_of :url, :maximum => 40
  validates_format_of :url, :with => /^[a-z0-9_]+$/i
  
  named_scope :active, :conditions => {:active => true}
  named_scope :twitter_enabled, :conditions => ["twitter_username IS NOT NULL"]
  
  def self.find_by_url_or_id url_or_id
    self.find_by_url(url_or_id) || self.find(url_or_id)
  end
  
  def twitter_tag
    if read_attribute(:twitter_tag).blank?
      nickname.downcase
    else
      read_attribute(:twitter_tag)
    end
  end
  
  def nickname
    read_attribute(:nickname) || name
  end
end
