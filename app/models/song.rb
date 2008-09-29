class Song < ActiveRecord::Base
  belongs_to :setting
  
  validates_presence_of :title
  
  def url
    "#{setting.songs_host}/#{filename}"
  end
  
  def self.with_file
    self.find(:all, :conditions => "filename IS NOT NULL", :order => "created_at DESC")
  end
  
  def filename
    f = attributes['filename']
    f.nil? ? nil : (f.match(/\..../) ? f : "#{f}.mp3")
  end
end
