// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var map;
function init_map(){
  // FIXME: rails root_path needs to be taken into account here!
  OpenLayers.ImgPath = '/images/'

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
