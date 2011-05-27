require 'spec_helper'

describe "presentations" do

  it "can be instantiated" do
    p = Presentation.new
  end

  it "should have a title" do
    p = Presentation.new
    p.title = "test title"
    p.title.should == "test title"
  end

end

