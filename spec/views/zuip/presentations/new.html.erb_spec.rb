require 'spec_helper'

describe 'zuip/presentations/new.html.erb' do
  describe "form fields content" do
    before(:each) { render }
    it { rendered.should have_css("label", :text => "Title")
         rendered.should have_css("input[type=text]")}
    it { rendered.should have_css("label", :text => "Filename")
         rendered.should have_css("input[type=text]")}
    it { rendered.should have_css("input[type=submit][value=create]") }
  end
end
