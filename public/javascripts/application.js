// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var map;
function init_map(){
  // because we wanted to consider rails root_path, this has been moved to
  // layouts/zuip. FIXME: move back here, once we can call rails helper methods
  // OpenLayers.ImgPath = '/images/'

  controls =
  [
    new OpenLayers.Control.Navigation(),
    new OpenLayers.Control.PanZoomBar(),
    new OpenLayers.Control.LayerSwitcher(),
    new OpenLayers.Control.Permalink('permalink'),
    new OpenLayers.Control.KeyboardDefaults(),
  ]
  options =
  {
    controls : controls,
    fractionalZoom : true,
  }

  map = new OpenLayers.Map('map', options);

  // this will be defined in app/views/zuip/presentation/show.html.erb
  loadBaseLayer();

  if (!map.getCenter()) {
    map.zoomToMaxExtent();
  }
}

function lastWaypointLink() {
  current_waypoint = $('ol#outline a.current');
  if (!current_waypoint) return;

  return current_waypoint.parent('li').prev('li').find('a');
}

function nextWaypointLink() {
  current_waypoint = $('ol#outline a.current');
  if (!current_waypoint) return;

  return current_waypoint.parent('li').next('li').find('a');
}
