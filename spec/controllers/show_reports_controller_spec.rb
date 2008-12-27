require File.dirname(__FILE__) + '/../spec_helper'

context "The ShowReportsController" do
  # fixtures :show_reports
  controller_name :show_reports

  specify "should be a ShowReportsController" do
    controller.should_be_an_instance_of ShowReportsController
  end


  specify "should have more specifications" do
    violated "not enough specs"
  end
end
