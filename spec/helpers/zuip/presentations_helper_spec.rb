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
end
