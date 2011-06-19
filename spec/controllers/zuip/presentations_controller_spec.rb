require 'spec_helper'

describe Zuip::PresentationsController do

  describe "GET 'show'" do
    it "should be successful with parameter \"name\"" do
      get 'show', :name => "test"
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
  end

end
