require 'nokogiri'

module Zuip
  module Parser
    private
    def content_element
      e = @doc.css("svg g#content")
      return e.first if e.size == 1
      raise ParsingError
    end

    def parse_xml(value)
      @doc = Nokogiri::XML.parse(value)
    end
  end
end
