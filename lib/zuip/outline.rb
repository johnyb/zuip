module Zuip
  module Outline
    private
    def waypoints_element
      @doc.css("svg g#waypoints").first
    end

    def find_waypoints(root, level = "#", headlines = [], parent_path = "")
      waypoints = root>("g")
      waypoints.each do |wp|
        info = wp_info(wp, level, parent_path)
        headlines << info
        find_waypoints wp, level+"#", headlines, info[:path]
      end
      headlines
    end

    def wrap(s, w)
      "#{w} #{s} #{w}"
    end

    def wp_info(wp, level, parent_path)
      parent_path += " / " unless parent_path.empty?
      title = (wp > "title").first.content
      rect = (wp > "use").first
      translate, scale = rect.attribute("transform").value.split(" ")
      translate.match /^translate\((.*),(.*)\)$/
      x = $1.to_f
      y = $2.to_f
      scale.match /^scale\((.*)\)$/
      scale = $1.to_f
      {:name => wrap(title, level),
       :path => parent_path + title,
       :x => x, :y => y, :scale => scale}
    end
  end
end
