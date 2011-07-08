Given /^a landscape$/ do
  visit '/presentations/new'
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

When /^I add an asset of "([^"]*)" type named "([^"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the landscape contains (\d+) objects$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
