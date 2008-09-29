class Show < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"
  belongs_to :venue
  
  validates_presence_of :date, :venue
end
