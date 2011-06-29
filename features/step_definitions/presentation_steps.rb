Given /^a ZUI presentation "([^"]*)"$/ do |title|
  @presentation = Zuip::Presentation.new(:source => path_to_presentation(title))
  visit '/zuip/presentations/presentations'
end

Given /^the outline$/ do |table|
  # table is a Cucumber::Ast::Table
  outline = table.hashes.map{ |h| h[:name] }
  @presentation.outline.size.should == outline.size
  @presentation.outline.should == outline
end

Given /^I see the content of "([^"]*)"$/ do |waypoint|
  raise "I am getting implemented"
end

Given /^I am viewing the presentation about presentations$/ do
  visit '/zuip/presentations/presentations'
end

Given /^I see the content of "([^"]*)"$/ do |waypoint|
  pending # express the regexp above with the code you wish you had
end

Given /^the element "([^"]*)" is hidden$/ do |id|
  click_link "hide_#{id}" if find("##{id}").visible?
end

When /^I open the outline$/ do
  When "I follow \"Show Outline\""
end

Then /^the element "([^"]*)" is visible$/ do |id|
  find("##{id}").should be_visible
end

Then /^I should see the content of "([^"]*)"$/ do |waypoint|
  pending # express the regexp above with the code you wish you had
end
