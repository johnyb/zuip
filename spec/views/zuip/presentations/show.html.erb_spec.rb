require 'spec_helper'

describe "zuip/presentations/show.html.erb" do
  before(:each) do
    p = double(Zuip::Presentation, :title => "Test title")
    view.stub(:presentation) { p }
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
end
