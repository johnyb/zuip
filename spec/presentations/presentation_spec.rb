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

  context "has an outline which" do
    let(:op) { p.outline = ["# Title #", "## Advantages ##", "## Disadvantages ##"]; p }

    it "should be provided as an array" do
      op.outline.size.should == 3
    end

    it "should have a current position" do
      op.current.should == "# Title #"
    end

    it "should have a changable current position" do
      op.current = "## Advantages ##"
      op.current.should == "## Advantages ##"
    end
  end
end

