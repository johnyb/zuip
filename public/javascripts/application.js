// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var map;
function init_map(){
  OpenLayers.ImgPath = '/images/'
  // HACK: temporarily override internal method to fix stylesheet loading
  tmp = OpenLayers._getScriptLocation;
  OpenLayers._getScriptLocation = function() { return '/'; };
  map = new OpenLayers.Map('map');
  OpenLayers._getScriptLocation = tmp;
  map.addControl(new OpenLayers.Control.LayerSwitcher());
  // this will be defined in app/views/zuip/presentation/show.html.erb
  loadBaseLayer();
  map.zoomToExtent(new OpenLayers.Bounds(0, 0, 1024, 768));
}
