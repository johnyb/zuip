module Zuip::PresentationsHelper
  def zuip_path(name)
    "#{root_path}assets/zuip/#{name}.svg"
  end
end
