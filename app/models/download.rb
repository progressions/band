class Download < ActiveRecord::Base
  belongs_to :fan
  
  default_scope :order => "created_at DESC"
end
