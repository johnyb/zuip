require 'spec_helper'

describe "zuip/presentations/show.html.erb" do
  before(:each) do
    @p = double(Zuip::Presentation, :title => "Test title", :outline => [])
    assign(:presentation, @p)
    view.stub(:name) { "test_name" }
  end

  it "should render with presentation" do
    render
    rendered.should contain("Test title")
    rendered.should have_selector("div", :id => "map")
  end

  it "should render a javascript function \"loadBaseLayer\"" do
    render
    rendered.should contain("function loadBaseLayer(")
  end

  describe "renders an outline panel which" do
    it "should be hideable by the user" do
      render
      rendered.should have_selector("div", :id => "outline_panel")
      rendered.should have_selector("ol", :id => "outline")
      rendered.should have_selector("a", :id => "hide_outline")
      rendered.should have_selector("a", :id => "show_outline")
    end

    it "should contain an outline" do
      @p.stub(:outline) { ["# Title #",
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
      render
      @p.outline.each { |name| rendered.should have_selector("ol#outline > li", :content => name ) }
    end
  end
end
