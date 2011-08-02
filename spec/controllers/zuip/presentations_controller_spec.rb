require 'spec_helper'

describe Zuip::PresentationsController do

  describe "GET 'show'" do
    it "should be successful with parameter \"name\"" do
      get 'show', :name => "presentations"
      response.should be_success
      response.should render_template("zuip/presentations/show")
      response.should render_template("layouts/zuip")
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

  describe "GET 'index'" do
    it "should not fail with empty svg files in assets dir" do
      File.new(File.join(Rails.root,"public","assets","zuip","empty_test.svg"),"w+")
      get 'index'
      assigns(:presentations)
      File.delete(File.join(Rails.root,"public","assets","zuip","empty_test.svg"))
    end

    it "assigns a few presentations" do
      get 'index'
      assigns(:presentations).should_not be_empty
    end

    it "assigns no presentations that are nil" do
      File.new(File.join(Rails.root,"public","assets","zuip","empty_test.svg"),"w+")
      get 'index'
      assigns(:presentations).each { |p| p.should_not be_nil }
      File.delete(File.join(Rails.root,"public","assets","zuip","empty_test.svg"))
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
      response.should render_template("zuip/presentations/new")
      response.should render_template("layouts/application")
    end

    it "should create an empty presentation" do
      get 'new'
      assigns(:presentation).should_not be_nil
    end
  end

  describe "POST 'create'" do
    let(:new_presentation) do { :presentation => {:title => "New Testpresentation", :fileName => "test"}} end
    it "fails and sends flash error when file exists" do
      f = File.join(Rails.root,"public","assets/zuip","test.svg")
      post 'create', new_presentation unless File.exists?(f)
      post 'create', new_presentation
      request.flash[:error].should =~ /Presentation with this filename already exists/
      response.should redirect_to new_presentations_path
    end

    it "creates a new presentation" do
      f = File.join(Rails.root,"public","assets/zuip","test.svg")
      File.delete(f) if File.exists?(f)
      post 'create', new_presentation
      response.should redirect_to edit_presentations_path('test')
    end

    it "the zuip path helper strips the extension from the fileName" do
      controller.instance_eval do
        def p_zuip_path(name)
          zuip_path(name)
        end
      end
      controller.p_zuip_path('test.svg').should eq(controller.p_zuip_path('test'))
    end
  end

  describe "GET 'edit'" do
    let(:new_presentation) do { :presentation => {:title => "New Testpresentation", :fileName => "test"}} end
    before(:each) do
      f = File.join(Rails.root,"public","assets/zuip","test.svg")
      File.delete(f) if File.exists?(f)
      post 'create', new_presentation
    end

    it "should render the edit partial for existing presentation" do
      get 'edit', :name => 'test'
      assigns(:presentation).title.should eq("New Testpresentation")
      response.should render_template('zuip/presentations/edit')
      response.should render_template('layouts/application')
    end

    it "fails when file doesn’t exist" do
      get 'edit', :name => 'bar'
      assigns(:presentation).should be_nil
      request.flash[:alert].should =~ /bar\.svg$/
      response.should redirect_to presentations_path
    end
  end

  describe "PUT 'update'" do
    let(:p) { Zuip::Presentation.new(:source => "#{RSpec.configuration.fixture_path}/presentations.svg") }
    let(:data) do
      { :name => 'presentations',
        :presentation => { :title => 'About Zooming Presentations', :fileName => 'presentations.svg'},
        :asset_0 => p.assets[0],
        :asset_1 => p.assets[1],
        :asset_2 => p.assets[2],
        :asset_3 => p.assets[3],
        :asset_4 => p.assets[4],
        :commit => 'Save'
        }
    end
    it "should find the presentation" do
      put 'update', data
      assigns(:presentation).fileName.should eq('presentations.svg')
      response.should redirect_to named_presentations_path(data[:name])
    end

    it "should rename the file" do
      put 'update', data.merge({ :presentation => { :title => 'About Zooming Presentations', :fileName => 'presentations_tmp.svg' }})
      response.should redirect_to named_presentations_path(assigns(:presentation).fileName.chomp!('.svg'))
      assigns(:presentation).fileName.should eq('presentations_tmp.svg')
      f_old = File.join(Rails.root,"public","assets","zuip","presentations.svg")
      f_new = File.join(Rails.root,"public","assets","zuip","presentations_tmp.svg")
      File.exists?(f_old).should be_false
      File.rename(f_new, f_old)
    end

    it "should update the title" do
      put 'update', data.merge({ :presentation => { :title => 'temp_title', :fileName => 'presentations.svg' }})
      response.should redirect_to named_presentations_path('presentations')
      controller.instance_eval do
        def p_zuip_path(name)
          zuip_path(name)
        end
      end
      # reload the presentation from the file
      assigns(:presentation).source = controller.p_zuip_path(assigns(:presentation).fileName)
      assigns(:presentation).title.should eq('temp_title')
      #reset the title
      assigns(:presentation).title = data[:presentation][:title]
      assigns(:presentation).save
    end

    it "should update the assets" do
      put 'update', data.merge({ :asset_3 => p.assets[0]})
      response.should redirect_to named_presentations_path('presentations')
      controller.instance_eval do
        def p_zuip_path(name)
          zuip_path(name)
        end
      end
      # reload the presentation from the file
      assigns(:presentation).source = controller.p_zuip_path(assigns(:presentation).fileName)
      assigns(:presentation).assets[3].should eq(p.assets[0])
      assigns(:presentation).assets[3].should_not eq(p.assets[3])
      # reset the assets
      assigns(:presentation).assets = p.assets
      assigns(:presentation).save
    end
  end
end
