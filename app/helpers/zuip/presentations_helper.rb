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
end
