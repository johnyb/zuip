require 'nokogiri'

module Zuip
  class ParsingError < ::StandardError
  end

  class Presentation

    def initialize(params)
      self.source=params[:source]
    end

    def title
      dc_titles = @doc.css('dc|title')
      raise ParsingError unless dc_titles.count == 1
      dc_titles.first.content
    end

    def outline=(o)
      raise ArgumentException unless o.class == Array
      @outline = o
    end

    def outline
      parse_outline if @outline.nil?
      @outline
    end

    def source=(s)
      @source = s
      reload
    end

    private
    def reload
      raise Errno::ENOENT unless File.exists?(@source)
      @doc = Nokogiri::XML.parse( File.new(@source) )
      @outline = nil
    end

    def parse_outline
      @outline = []
      find_waypoints(@doc.css(".waypoints").first)
    end

    def find_waypoints(root, level = "#")
      waypoints = root>("rect > title")
      waypoints.each do |wp|
        @outline.push wrap(wp.content, level)
        candidate = wp.parent.next_element
        if candidate && candidate.node_name == "g" then
          find_waypoints candidate, level+"#"
        end
      end
    end

    def wrap(s, w)
      "#{w} #{s} #{w}"
    end
  end
end
