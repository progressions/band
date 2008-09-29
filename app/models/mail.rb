class Mail < ActiveRecord::Base  
  belongs_to :user, :foreign_key => "created_by"
  
  validates_presence_of :title, :body
  
  def self.search(search, page)
    if search
      search = "%#{search}%"
      paginate :per_page => 5, :page => page,
        :conditions => ['title LIKE ? OR body LIKE ?', search, search],
        :order => 'created_at DESC'
    else
      find(:all)
    end
  end
end
