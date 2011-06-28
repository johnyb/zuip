Given /^a ZUI presentation "([^"]*)"$/ do |title|
  @presentation = Zuip::Presentation.new(:source => path_to_presentation(title))
end

Given /^the outline$/ do |table|
  # table is a Cucumber::Ast::Table
  outline = table.hashes.map{ |h| h[:name] }
  @presentation.outline = outline
  @presentation.outline.size.should == table.hashes.size
end

Given /^I am viewing the presentation about presentations$/ do
  visit '/zuip/presentations/presentations'
end

Given /^the element "([^"]*)" is hidden$/ do |id|
  click_link "hide_#{id}" if find("##{id}").visible?
end

Then /^the element "([^"]*)" is visible$/ do |id|
  find("##{id}").should be_visible
end
