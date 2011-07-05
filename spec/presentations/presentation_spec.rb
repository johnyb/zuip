require 'spec_helper'

describe "A Presentation" do
  let(:p) { Zuip::Presentation.new(:source => "#{RSpec.configuration.fixture_path}/presentations.svg") }

  it "can be instantiated" do
    p.should_not be(nil)
  end

  context "with information parsed from the SVG file:" do
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

      it "should be provided as an hash with names" do
        p.outline.map{ |item| item[:name] }.should == outline
      end

      it "should have information about the bounding box of each item" do
        expected = [[200,80,0.8],[-70,300,0.23],[-70,460,0.23],[-40,690,0.23],[475.0, 290.0, 0.27],
                    [475,460,0.33],[445,690,0.25],[250,-100,0.9],[-200,-150,0.23],[250,-150,0.23],
                    [150,0,2]]
        expected.each { |i| i.map!{ |j| j.to_f } }
        res = p.outline.map{ |item| [item[:x],item[:y],item[:scale]] }
        res.should == expected
      end

      it "should have information about the parents of each item" do
        expected = ["Title","Slides","Slides / Advantages","Slides / Problems","ZUI Presentations",
                    "ZUI Presentations / Advantages","ZUI Presentations / Problems","Solutions",
                    "Solutions / Prezi","Solutions / CounterPoint","Solutions / ZUIP"]
        p.outline.map{ |item| item[:path] }.should == expected
      end
    end

    describe "bounding box" do
      it "should extract the view box" do
        left, top, width, height = [-1050,-900,2400,1800]
        p.viewBox.should == [left, top, width, height]
      end

      it "should extract extents of waypoint marker" do
        p.waypointMarkerSize.should.== [1200,900]
      end
    end
  end
end
