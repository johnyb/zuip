require 'nokogiri'

module Zuip
  class ParsingError < ::StandardError
  end

  class Presentation
    include Zuip::Parser
    include Zuip::Outline

    def initialize(params = {})
      if params[:source] then
        self.source=params[:source]
        return
      end
      @doc = Nokogiri::XML.parse(initial_svg)
    end

    def title
      dc_titles = @doc.css('dc|title')
      raise ParsingError unless dc_titles.count == 1
      dc_titles.first.content
    end

    def title=(t)
      dc_titles = @doc.css('dc|title')
      raise ParsingError unless dc_titles.count == 1
      dc_titles.first.content = t
    end

    def viewBox
      svg_elem = @doc.css('svg').first
      value = svg_elem.attribute('viewBox').value
      value.split(" ").map{ |v| v.to_f }
    end

    def waypointMarkerSize
      rect = @doc.css("defs > g#waypoint > rect").first
      [rect.attribute("width").value.to_f,rect.attribute("height").value.to_f]
    end

    def file=(name)
      raise Errno::EEXIST if File.exists?(name)

      @source = name
      Dir.mkdir(File.dirname(@source)) unless File.exists?(File.dirname(@source))
      save(true)
    end
    def fileName
      return nil if @source.nil?

      File.basename(@source)
    end

    def outline
      reload if @outline.nil?
      @outline
    end

    def source=(s)
      @source = s
      reload
    end

    def to_svg
      @doc.to_s
    end

    def assets
      assets = []
      (content_element > "g.content").each { |a| assets << a.to_s }
      assets
    end

    def assets=(list)
      content_element.inner_html = ""
      list.each do |str|
        f = Nokogiri::XML::DocumentFragment.parse(str)
        content_element << f
      end
    end

    def content
      content_element.inner_html.to_s
    end

    def content=(str)
      f = Nokogiri::XML::DocumentFragment.parse(str)
      content_element.inner_html = f
    end

    def save(create = false)
      return false unless create || (!@source.nil? && File.exists?(@source))

      File.open(@source,"w+") do |f|
        @doc.write_xml_to(f)
      end
      true
    end

    private
    def reload
      raise Errno::ENOENT unless File.exists?(@source)
      parse_xml(File.new(@source))
      @outline = find_waypoints(waypoints_element)
    end

    def initial_svg
      '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
      <svg
        xmlns:dc="http://purl.org/dc/elements/1.1/"
        xmlns:cc="http://creativecommons.org/ns#"
        xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
        xmlns:svg="http://www.w3.org/2000/svg"
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 2400 1800">
      <defs>
      <g id="waypoint" style="opacity:0.001;color:#000000;fill:none;stroke:#004000;stroke-width:5;">
      <rect x="-600" y="-450" width="1200" height="900" />
      <line x1="-600" y1="-450" x2="600" y2="450" transform="scale(0.05)" />
      <line x1="600" y1="-450" x2="-600" y2="450" transform="scale(0.05)" />
      </g>
      <style type="text/css">
      <![CDATA[
        text {
          font-family : helvetica;
        }
      ]]></style>
      </defs>
      <metadata><rdf:RDF>
      <dc:title></dc:title>
      </rdf:RDF></metadata>
      <g id="content"></g>
      <g id="waypoints" class="waypoints"></g>
      </svg>
      '
    end
  end

end
