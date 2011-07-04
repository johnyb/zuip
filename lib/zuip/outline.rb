module Zuip
  module Outline
    private
    def waypoints_element
      @doc.css("#waypoints").first
    end

    def find_waypoints(root, level = "#", headlines = [])
      waypoints = root>("g")
      waypoints.each do |wp|
        headlines << wp_info(wp, level)
        find_waypoints wp, level+"#", headlines
      end
      headlines
    end

    def wrap(s, w)
      "#{w} #{s} #{w}"
    end

    def wp_info(wp, level)
      title = (wp > "title").first.content
      rect = (wp > "use").first
      translate, scale = rect.attribute("transform").value.split(" ")
      translate.match /^translate\((.*),(.*)\)$/
      x = $1.to_f
      y = $2.to_f
      scale.match /^scale\((.*)\)$/
      scale = $1.to_f
      {:name => wrap(title, level), :x => x, :y => y, :scale => scale}
    end
  end
end
