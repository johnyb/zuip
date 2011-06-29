require 'nokogiri'

module Zuip
  class ParsingError < ::StandardError
  end

  class Presentation
    include Zuip::Parser
    include Zuip::Outline

    def initialize(params)
      self.source=params[:source]
    end

    def title
      dc_titles = @doc.css('dc|title')
      raise ParsingError unless dc_titles.count == 1
      dc_titles.first.content
    end

    def outline
      reload if @outline.nil?
      @outline.to_a
    end

    def source=(s)
      @source = s
      reload
    end

    private
    def reload
      raise Errno::ENOENT unless File.exists?(@source)
      parse_xml(File.new(@source))
      @outline = find_waypoints(waypoints_element)
    end
  end

end
