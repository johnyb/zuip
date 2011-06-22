Given /^a ZUI presentation "([^"]*)"$/ do |title|
  @presentation = Zuip::Presentation.new(:source => path_to_presentation(title))
end

Given /^the outline$/ do |table|
  # table is a Cucumber::Ast::Table
  outline = table.hashes.map{ |h| h[:name] }
  @presentation.outline = outline
  @presentation.outline.size.should == table.hashes.size
end

Given /^the element "([^"]*)" is hidden$/ do |id|
  page.should have_css("##{id}")
  page.execute_script("$('##{id}').hide();")
end

Then /^the element "([^"]*)" is visible$/ do |id|
  find("##{id}").visible?.should be_true
end
