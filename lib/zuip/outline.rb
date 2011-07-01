module Zuip
  module Outline
    private
    def waypoints_element
      @doc.css("#waypoints").first
    end

    def find_waypoints(root, level = "#", headlines = [])
      waypoints = root>("g")
      waypoints.each do |wp|
        title = (wp > "title").first.content
        headlines << wrap(title, level)
        find_waypoints wp, level+"#", headlines
      end
      headlines
    end

    def wrap(s, w)
      "#{w} #{s} #{w}"
    end
  end
end
