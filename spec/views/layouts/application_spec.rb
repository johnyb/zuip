require 'spec_helper'

describe "layouts/application" do
  it "should render alert notices" do
    flash[:alert] = 'Error'
    render
    rendered.should have_css("div#alert", :content => 'Error')
  end

  it "should not render the alert div without flash" do
    render
    rendered.should_not have_css("div#alert")
  end
end
