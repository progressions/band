require File.dirname(__FILE__) + '/../spec_helper'

context "ShowReport class with fixtures loaded" do
  fixtures :show_reports

  specify "should count two ShowReports" do
    ShowReport.count.should_be 2
  end

  specify "should have more specifications" do
    violated "not enough specs"
  end
end
