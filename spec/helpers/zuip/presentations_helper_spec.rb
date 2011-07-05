require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the Zuip::PresentationsHelper. For example:
#
# describe Zuip::PresentationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe Zuip::PresentationsHelper do
  it "creates correct paths to assets/zuip folder" do
    helper.zuip_path("test").should eq("/assets/zuip/test.svg")
  end
  it "creates correct paths when root_path is set" do
    helper.stub!(:root_path) { "/zuip/" }
    helper.zuip_path("test").should eq("/zuip/assets/zuip/test.svg")
  end
  it "generates JS to map viewBox to OpenLayers.Bounds" do
    helper.olBoundsForViewBox([-1050, -900, 2400, 1800]).should eq("new OpenLayers.Bounds(-1050, -900, 1350, 900)")
  end
  it "creates JavaScript code that navigates map to given coordinates" do
    @presentation = double(Zuip::Presentation, :waypointMarkerSize => [1200,900])
    js = helper.olNavigateTo({:x => 100, :y => 200, :scale => 1})
    js.should =~ /map\.zoomToExtent/
  end

  it "creates ids for outline links" do
    helper.idForOutlineLink({:path => "Title"}).should == "outline_link_title"
    helper.idForOutlineLink({:path => "Slides / Problems"}).should == "outline_link_slides__problems"
  end
end
