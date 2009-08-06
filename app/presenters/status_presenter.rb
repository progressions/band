module MailingListPresenter
  def self.included(klass)
    klass.send :extend, ClassMethods
    klass.send :include, InstanceMethods
    
    klass.send :present, :new_fans, :new_unsubscribed_fans, :new_deliveries
  end

  module ClassMethods
  end
  
  module InstanceMethods
    def new_fans
      @new_fans ||= Fan.created_since(since_date)
    end
  
    def new_unsubscribed_fans
      @new_unsubscribed_fans ||= Fan.unsubscribed_since(since_date)
    end
  
    def total_fan_count
      @total_fan_count ||= Fan.active.count
    end
  
    def new_deliveries
      @new_deliveries ||= Delivery.created_since(since_date)
    end
    
    def new_deliveries_fan_count
      new_deliveries.sum(:fan_count)
    end
  end
end

module ShowsPresenter
  def self.included(klass)
    klass.send :extend, ClassMethods
    klass.send :include, InstanceMethods
    
    klass.send :present, :new_scheduled_shows, :new_performed_shows
  end

  module ClassMethods
  end
  
  module InstanceMethods    
    def new_scheduled_shows
      @new_scheduled_shows ||= Show.created_since(since_date)
    end
  
    def new_performed_shows
      @new_performed_shows ||= Show.performed_since(since_date)
    end
  end
end

module WebsitePresenter
  def self.included(klass)
    klass.send :extend, ClassMethods
    klass.send :include, InstanceMethods
    
    klass.send :present, :new_blogs, :new_entries, :new_comments
  end

  module ClassMethods
  end
  
  module InstanceMethods
    def new_blogs
      @new_blogs ||= Blog.created_since(since_date)
    end
    
    def new_entries
      @new_entries ||= Entry.created_since(since_date)
    end
  end
end

class StatusPresenter < Presenter
  include MailingListPresenter
  include ShowsPresenter
  include WebsitePresenter
  
  attr_accessor :since_date, :site
  
  def from_date
    strftime(since_date)
  end
  
  def to_date
    strftime(Time.now)
  end
  
  def since_date
    @since_date || 1.day.ago
  end
  
  def age
    Time.now - since_date
  end
  
  private
  
  def strftime(date)
    date.strftime("%B %d, %Y")
  end
end