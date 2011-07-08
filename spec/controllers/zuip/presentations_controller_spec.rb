require 'spec_helper'

describe Zuip::PresentationsController do

  describe "GET 'show'" do
    it "should be successful with parameter \"name\"" do
      get 'show', :name => "presentations"
      response.should be_success
      response.should render_template("zuip/presentations/show")
    end

    it "should redirect to to index without parameter \"name\"" do
      get 'show'
      response.should redirect_to(presentations_path)
    end

    it "should show an error message when the file is not found" do
      get 'show', :name => 'file_doesnt_exist'
      flash[:alert].should contain("file_doesnt_exist")
      response.should redirect_to(presentations_path)
    end

    it "should provide a presentation containing an outline" do
      get 'show', :name => "presentations"
      assigns(:presentation).outline.size.should == 11
    end

    it "should find the correct path to a presentation asset under different rails root" do
      Rails.stub!(:root) { "/does_not/exist/" }
      get 'show', :name => "presentations"
      flash[:alert].should =~ /\/does_not\/exist\/public\/assets\/zuip\/presentations.svg$/
      response.should_not be_success
    end
  end

end
