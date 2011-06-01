Given /^a ZUI presentation "([^"]*)"$/ do |title|
  @presentation = ZUIP::Presentation.new
  @presentation.title = title
end

Given /^the outline$/ do |table|
  # table is a Cucumber::Ast::Table
  outline = table.hashes.map{ |h| h[:name] }
  @presentation.outline = outline
  @presentation.outline.size.should == table.hashes.size
end
