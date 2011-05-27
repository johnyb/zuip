Given /^a ZUI presentation "([^"]*)"$/ do |title|
  @presentation = ZUIP::Presentation.new
  @presentation.title = title
end

Given /^the outline$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end
