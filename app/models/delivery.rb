class Delivery < ActiveRecord::Base
  belongs_to :mail
  
  named_scope :created_since, lambda {|since_date| {:conditions => ["created_at >= ?", since_date]}}
end
