require File.dirname(__FILE__) + '/../spec_helper'

context "The ShowRatingsController" do
  # fixtures :show_ratings
  controller_name :show_ratings

  specify "should be a ShowRatingsController" do
    controller.should_be_an_instance_of ShowRatingsController
  end


  specify "should have more specifications" do
    violated "not enough specs"
  end
end
