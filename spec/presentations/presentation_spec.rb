require 'spec_helper'

describe "A Presentation" do
  let(:p) { Zuip::Presentation.new(:source => "#{RSpec.configuration.fixture_path}/presentations.svg") }

  it "can be instantiated" do
    p.should_not be(nil)
  end

  context "with information parsed from the SVG file:" do
    describe "the outline" do
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

      it "should raise an error if no title is found" do
        xml = '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
        <svg xmlns:dc="http://purl.org/dc/elements/1.1/">
        <metadata><rdf:RDF>
        </rdf:RDF></metadata>
        </svg>'
        p.instance_eval {@doc = Nokogiri::XML.parse(xml) }
        begin
          p.title.should be_nil
        rescue Zuip::ParsingError, Nokogiri::XML::XPath::SyntaxError
          #these are fine
        end
      end

      it "should have an outline provided as an array" do
        p.outline.should == outline
      end
    end

    describe "bounding box" do
      it "should extract the view box" do
        left, top, width, height = [-1050,-900,2400,1800]
        p.viewBox.should == [left, top, width, height]
      end
    end
  end
end
