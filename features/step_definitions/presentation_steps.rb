Given /^a ZUI presentation "([^"]*)"$/ do |title|
  @presentation = Zuip::Presentation.new(:source => path_to_presentation(title))
  visit '/presentations/presentations'
end

Given /^the outline$/ do |table|
  # table is a Cucumber::Ast::Table
  outline = table.hashes.map{ |h| h[:name] }
  @presentation.outline.size.should == outline.size
  @presentation.outline.map{ |item| item[:name] }.should == outline
end

Given /^I see the content of "([^"]*)"$/ do |waypoint|
  click_link 'show_outline'

  When "I click the waypoint \"#{waypoint}\""

  click_link 'hide_outline'
end

Given /^I am viewing the presentation about presentations$/ do
  visit '/presentations/presentations'
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
  id = waypoint.downcase.delete("/").split(" ").join('__')
  id = "outline_link_#{id}"
  find("##{id}")[:class].should =~ /current/
end

When /^I click the waypoint "([^"]*)"$/ do |waypoint|
  id = waypoint.downcase.delete("/").split(" ").join('__')
  click_link "outline_link_#{id}"
end
