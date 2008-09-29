class Entry < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"
  
  validates_presence_of :title, :body
end
