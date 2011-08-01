require 'spec_helper'

describe 'zuip/presentations/edit.html.erb' do
  before(:each) do
    assign(:presentation, Zuip::Presentation.new(:source => "#{RSpec.configuration.fixture_path}/presentations.svg"))
  end
  describe "form fields content" do
    before(:each) { render }
    it { rendered.should have_css("form") }
    it { rendered.should have_css("form > label[for=presentation_title]") }
    it { rendered.should have_css("form > input[id=presentation_title]") }
    it { rendered.should have_css("form > label[for=presentation_title]") }
    it { rendered.should have_css("form > input[id=presentation_title]") }
    it { (0..4).each { |i| rendered.should have_css("form > textarea[id=asset_#{i}]") } }
    it { pending "implement l10n!" do
           rendered.should have_css("form > input[type=submit][value=Cancel]")
         end }
    it { pending "implement l10n!" do
           rendered.should have_css("form > input[type=submit][value=Save]")
         end }
  end
end
