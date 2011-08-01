require 'spec_helper'

describe 'zuip/presentations/index.html.erb' do
  describe "the list of presentations" do
    before(:each) do
      p = []
      p << double(Zuip::Presentation, :title => "Testpresentation", :fileName => "test.svg")
      p << double(Zuip::Presentation, :title => "Another Testpresentation", :fileName => "test2.svg")
      assign(:presentations, p)
      render
    end

    it "should render some presentations" do
      rendered.should have_css("ol > li", :text => "Testpresentation")
      rendered.should have_css("ol > li", :text => "Another Testpresentation")
    end

    it "should have links to show each presentation" do
      rendered.should have_link("Testpresentation", {:href => named_presentations_path("test")})
      rendered.should have_link("Another Testpresentation", {:href => named_presentations_path("test2")})
    end

    it "should have links to edit each presentation" do
      rendered.should have_link("Edit", {:href => edit_presentations_path("test")})
      rendered.should have_link("Edit", {:href => edit_presentations_path("test2")})
    end
  end

  it "should provide a link to the create page" do
    assign(:presentations, [])
    render
    rendered.should have_css("a[href='#{new_presentations_path}']", :text => "New ZUI-Presentation")
  end
end