class Show < ActiveRecord::Base
  belongs_to :user, :foreign_key => "created_by"
  belongs_to :venue
  belongs_to :report, :class_name => "ShowReport"
  has_many :ratings, :class_name => "ShowRating"
  
  validates_presence_of :date, :venue
end
