require File.dirname(__FILE__) + '/../spec_helper'

describe ShowReport do
  it "should be valid" do
    ShowReport.new.should be_valid
  end
end
