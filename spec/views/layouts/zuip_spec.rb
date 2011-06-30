require 'spec_helper'

describe "layouts/zuip" do
  it "should change the ImgPath for OpenLayers" do
    ['/', '/some/arbitrary/path/'].each do |path|
      view.stub!(:root_path) {path}
      render
      rendered.should contain("ImgPath = '#{path}images/'")
    end
  end
end
