class Song < ActiveRecord::Base
  belongs_to :setting
  
  # has_friendly_id :title, :use_slug => true
  
  validates_presence_of :title
  
  def url
    "#{setting.songs_host}/#{filename}"
  end
  
  # TODO: paginate this?
  def self.find_all_with_file(count=5)
    self.find(:all, :conditions => "filename IS NOT NULL", :limit => count, :order => "created_at DESC")
  end
  
  def filename
    f = attributes['filename']
    f.nil? ? nil : (f.match(/\..../) ? f : "#{f}.mp3")
  end
end
