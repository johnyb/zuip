require 'nokogiri'

module Zuip
  module Parser
    private
    def parse_xml(value)
      @doc = Nokogiri::XML.parse(value)
    end
  end
end
