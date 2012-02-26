class Lyric < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"
  
  # has_friendly_id :title, :use_slug => true
  
  validates_presence_of :title, :body
  validates_uniqueness_of :title, :body
  
  def self.search(search, page)
    if search
      search = "%#{search}%"
      paginate :per_page => 5, :page => page,
        :conditions => ['title LIKE ? OR body LIKE ? OR composer LIKE ?', search, search, search],
        :order => 'created_at DESC'
    else
      find(:all)
    end
  end
  
  def self.sort(sort)
    if sort
      find(:all, :conditions => ['title LIKE ?', "#{sort}%"])
    else
      find(:all, :order => 'title')
    end  
  end
end
