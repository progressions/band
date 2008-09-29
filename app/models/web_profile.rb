class WebProfile < ActiveRecord::Base
  belongs_to :setting
  
  validates_presence_of :name, :url
end
