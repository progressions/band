class Style < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"
  belongs_to :setting
  
  validates_presence_of :title
end
