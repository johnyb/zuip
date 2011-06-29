module Zuip
  module Outline
    private
    def waypoints_element
      @doc.css("#waypoints").first
    end

    def find_waypoints(root, level = "#", headlines = [])
      waypoints = root>("rect > title")
      waypoints.each do |wp|
        headlines << wrap(wp.content, level)
        children = wp.parent.next_element
        if children && children.node_name == "g" then
          find_waypoints children, level+"#", headlines
        end
      end
      headlines
    end

    def wrap(s, w)
      "#{w} #{s} #{w}"
    end
  end
end
