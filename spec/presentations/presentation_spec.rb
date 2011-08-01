require 'spec_helper'

describe "A Presentation" do

  context "instantiated from scratch" do
    let(:p){ Zuip::Presentation.new }

    it "should be instantiated" do
      p.should_not be_nil
    end

    it "should have an empty title" do
      p.title.should be_empty
    end

    it "should have a bounding box" do
      left, top, width, height = [0,0,2400,1800]
      p.viewBox.should == [left, top, width, height]
    end

    it "should provide svg-code visualizing the presentation" do
      doc = Nokogiri::XML.parse(p.to_svg)
      doc.css("svg").should_not be_blank
      doc.css("svg defs g#waypoint").should_not be_blank
      doc.css("svg g#content").should_not be_blank
      doc.css("svg g#waypoints").should_not be_blank
      doc.errors.should be_empty
    end

    it "can receive a title" do
      p.title = "Test"
      p.title.should eq("Test")
    end

    describe "handles the content within the svg file" do
      it "should store the content in an svg file" do
        p.fileName.should be_nil
        f = File.join(Rails.root,"tmp","spec","presentations.svg")
        File.delete(f) if File.exists?(f)
        p.file = f
        p.fileName.should == "presentations.svg"
      end

      it "can be saved" do
        p.fileName.should be_nil
        f = File.join(Rails.root,"tmp","spec","presentations.svg")
        File.delete(f) if File.exists?(f)
        p.file = f
        p.title.should be_empty
        p.title = "Testtitle"
        p.save
        p = Zuip::Presentation.new(:source => "#{f}")
        p.title.should eq("Testtitle")
      end

      it "should update the content with a given string" do
        p.content.should be_empty
        example = '<g class="content"><rect x="10" y="10" width="100" height="100"></rect></g>'
        p.content=example
        p.content.should == example
        p.to_svg.should =~ /rect x="10" y="10" width="100" height="100"/
      end
    end
  end

  context "with information parsed from the SVG file:" do
    let(:p) { Zuip::Presentation.new(:source => "#{RSpec.configuration.fixture_path}/presentations.svg") }

    it "provides a file name" do
      p.fileName.should == "presentations.svg"
    end

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
        expected = [[250.0, 80.0, 0.8],
                    [-10.0, 350.0, 0.23],
                    [-100.0, 550.0, 0.23],
                    [-85.0, 770.0, 0.23],
                    [520.0, 350.0, 0.23],
                    [475.0, 550.0, 0.33],
                    [445.0, 770.0, 0.25],
                    [250.0, -120.0, 1.0],
                    [-250.0, -440.0, 0.23],
                    [250.0, -440.0, 0.23],
                    [150.0, 0.0, 2.0]]
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

  describe "assets handling" do
    let(:assets) do
      Dir[File.join(RSpec.configuration.fixture_path,"asset*.svg")].sort.map { |f| File.read(f) }
    end
    let(:p) { Zuip::Presentation.new }

    it "should assign content from assets" do
      p.content.should be_blank
      p.assets = assets
      p.content.should_not be_blank
    end

    it "should find assets in content" do
      p = Zuip::Presentation.new(:source => "#{RSpec.configuration.fixture_path}/presentations.svg")
      p.assets.size.should eq(assets.size)
    end
  end
end
