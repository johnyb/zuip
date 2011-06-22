require 'spec_helper'

describe "A Presentation" do
  let(:p) { Zuip::Presentation.new(:source => "#{RSpec.configuration.fixture_path}/presentations.svg") }

  it "can be instantiated" do
    p.should_not be(nil)
  end

  context "with information parsed from the SVG file" do
    let(:outline) { ["# Title #",
                     "# Slides #",
                     "## Advantages ##",
                     "## Problems ##",
                     "# ZUI Presentations #",
                     "## Advantages ##",
                     "## Problems ##",
                     "# Solutions #",
                     "## Prezi ##",
                     "## CounterPoint ##",
                     "## ZUIP ##"]
                  }

    it "should have a title" do
      p.title.should == "About Zooming Presentations"
    end

    it "should have an outline provided as an array" do
      pending "needs implementation"
      p.outline.should == outline
    end
  end
end

