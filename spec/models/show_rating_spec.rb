require File.dirname(__FILE__) + '/../spec_helper'

context "ShowRating class with fixtures loaded" do
  fixtures :show_ratings

  specify "should count two ShowRatings" do
    ShowRating.count.should_be 2
  end

  specify "should have more specifications" do
    violated "not enough specs"
  end
end
