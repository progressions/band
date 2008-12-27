class ShowRating < ActiveRecord::Base
  belongs_to :show
  belongs_to :member
end
