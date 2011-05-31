require 'spec_helper'

describe "presentations" do

  it "can be instantiated" do
    p = ZUIP::Presentation.new
  end

  it "should have a title" do
    p = ZUIP::Presentation.new
    p.title = "test title"
    p.title.should == "test title"
  end

end

