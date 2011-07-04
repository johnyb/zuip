module Zuip::PresentationsHelper
  def zuip_path(name)
    "#{root_path}assets/zuip/#{name}.svg"
  end

  def olBoundsForViewBox(viewBox)
    left, top, width, height = viewBox
    # OpenLayers.Bounds constructor takes arguments: left, bottom, right, top
    # calculation of center doesn’t work, when bottom > top, may be a bug in OpenLayers-code
    "new OpenLayers.Bounds(#{left}, #{-(top+height)}, #{left+width}, #{-top})"
  end

  def olNavigateTo(pos)
    width, height = @presentation.waypointMarkerSize
    width *= pos[:scale]
    height *= pos[:scale]
    viewBox = [pos[:x]-width/2,pos[:y]-height/2,width,height]
    "map.zoomToExtent(#{olBoundsForViewBox(viewBox)})"
  end
end
