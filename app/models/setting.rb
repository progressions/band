class Setting < ActiveRecord::Base
  has_one :promo
  has_one :style
  
  has_many :members
  has_many :pages
  has_many :web_profiles
  has_many :songs
  
	validates_email_veracity_of :email, :message => "Email is invalid"
	validates_email_veracity_of :admin_email, :message => "Email is invalid"
	
	# TODO: validate format of URL
   
  def url_filled?
    !url.blank?
  end 
	
	def songs_host
	  host = attributes['songs_host'].blank? ? url : with_protocol(attributes['songs_host'])
	end
	
	def show_videos?
	  !youtube_profile.blank? && read_attribute(:show_videos)
	end
	
	# TODO: fix twitter
	def show_twitter?
    !twitter_profile.blank? && read_attribute(:show_twitter)
	end
	
	# TODO: fix twitter
	def tweet_updates?
    show_twitter?
  end
	
	def has_web_profiles?
    !web_profiles.empty? || !facebook_profile.blank? || !myspace_profile.blank?
	end
	
	def can_send_mail?
	  !email.blank? && !url.blank?
  end
  
  def url_with_protocol
	  with_protocol(attributes['url'])
  end
  
  def url= link
	  write_attribute(:url, with_protocol(link))
  end
  
  protected
  
  def with_protocol link
	  link = link.match(/^http:\/\//) ? link : "http://#{link}"
	  link.gsub(/\/$/, "")
  end
end
