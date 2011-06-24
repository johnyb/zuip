require 'nokogiri'

module Zuip
  class Presentation
    attr_reader :outline

    def initialize(s)
      self.source=s[:source]
      @outline = []
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

    def source=(s)
      @source = s
      reload
    end

    private
    def reload
      raise Errno::ENOENT unless File.exists?(@source)
      @doc = Nokogiri::XML.parse( File.new(@source) )
    end
  end
end

