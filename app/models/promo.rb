class Promo < ActiveRecord::Base
  belongs_to :setting
  
  validates_presence_of :title, :body
end
