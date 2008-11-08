class Entry < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"
  
  has_friendly_id :title, :use_slug => true
  
  validates_presence_of :title, :body
end
