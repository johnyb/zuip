Given /^a landscape$/ do
  File.delete(path_to_presentation('test')) if File.exists?(path_to_presentation('test'))
  visit '/presentations/new'
  fill_in "Title", {:with => "New Testpresentation"}
  fill_in "Filename", {:with => "test.svg"}
  click_button :create
end

Given /^a landscape containing the objects$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

When /^I select the objects$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

When /^I group the selected objects$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the landscape contains (\d+) group with (\d+) objects$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^"([^"]*)" does not belong to a group$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I add an asset with svg code$/ do |code|
  asset_textarea = page.all(:css, 'form > div#assets_fields textarea').last
  asset_textarea.should_not be_nil
  page.fill_in asset_textarea[:id], :with => code
end

When /^I press the add asset button$/ do
  click_on 'add_asset_button'
end

Then /^the landscape contains (\d+) objects$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^there should be a presentation "([^"]*)"$/ do |name|
  f = path_to_presentation(name)
  File.should exist(f)
end

Given /^a presentation "([^"]*)" does not exist$/ do |name|
  f = path_to_presentation(name)
  File.delete(f) if File.exist?(f)
end
