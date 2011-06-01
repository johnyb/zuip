require 'spec_helper'

describe "A Presentation" do
  let(:p) { ZUIP::Presentation.new }

  it "can be instantiated" do
    p.should_not be(nil)
  end

  it "should have a title" do
    p.title = "test title"
    p.title.should == "test title"
  end

end

