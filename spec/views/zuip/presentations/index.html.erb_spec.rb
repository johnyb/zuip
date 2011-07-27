require 'spec_helper'

describe 'zuip/presentations/index.html.erb' do
  it "should list presentations" do
    p = []
    p << double(Zuip::Presentation, :title => "Testpresentation", :fileName => "test.svg")
    p << double(Zuip::Presentation, :title => "Another Testpresentation", :fileName => "test2.svg")
    assign(:presentations, p)
    render
    rendered.should have_css("ol > li", :text => "Testpresentation")
    rendered.should have_css("ol > li", :text => "Another Testpresentation")
  end

  it "should provide a link to the create page" do
    assign(:presentations, [])
    render
    rendered.should have_css("a[href='#{new_presentations_path}']", :text => "New ZUI-Presentation")
  end
end