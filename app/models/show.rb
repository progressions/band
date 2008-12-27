class Show < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"
  belongs_to :venue
  belongs_to :show_report
  has_many :show_ratings
  
  validates_presence_of :date, :venue
end
