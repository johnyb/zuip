Given /^the current position is at "([^"]*)"$/ do |name|
    visit "/presentations/presentations#{params_for_waypoint(name)}"
end

Given /^I can see "([^"]*)"$/ do |title|
  @initial_zoom = page.evaluate_script('map.zoom')
  @initial_lon, @initial_lat = page.evaluate_script('map.center.toShortString()').split(', ')
end

When /^I zoom in$/ do
  page.execute_script("map.zoomIn();")
end

Then /^the elements? should be larger$/ do
  page.evaluate_script('map.getZoom();').should > @initial_zoom
end

When /^I zoom out$/ do
  page.execute_script("map.zoomOut();")
end

Then /^the elements? should be smaller$/ do
  page.evaluate_script('map.getZoom();').should < @initial_zoom
end

When /^I pan to the left$/ do
  #run pan operation without animation because it broke the test (center does not change)
  page.execute_script("map.pan(-map.getSize().w / 4,0, {animate : false});")
end

Then /^the elements? should be more left$/ do
  lon,lat = page.evaluate_script('map.getCenter().toShortString()').split(', ')
  lon.should < @initial_lon
  (lat.to_f - @initial_lat.to_f).abs.should < 0.01
end
