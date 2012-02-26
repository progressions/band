class Email < ActiveRecord::Base
  self.table_name = "mail"
  belongs_to :user, :foreign_key => "created_by"
  has_many :deliveries
  
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
  
  def deliver(fan, delivery)
    if Mailer.deliver_mail(fan, self)
      delivery.increment!(:fan_count)
    end
  end
end
