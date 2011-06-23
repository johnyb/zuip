require 'spec_helper'

describe Zuip::PresentationsController do

  describe "GET 'show'" do
    it "should be successful with parameter \"name\"" do
      get 'show', :name => "presentations"
      response.should be_success
      response.should render_template("zuip/presentations/show")
    end

    it "should not be successful without parameter \"name\"" do
      begin
        get 'show'
      rescue ActionController::RoutingError
        everything_fine = true
      end
      raise "Failed!" unless everything_fine
    end

    it "should render the outline" do
      pending "won’t work until we stub Zuip::Presentation.outline or implement it"
      get 'show', :name => "presentations"
      response.should render_template(:partial => "_outline", :count => 11)
    end
  end

end
