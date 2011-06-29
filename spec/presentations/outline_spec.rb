require 'spec_helper'
require 'zuip/outline'

describe "An Outline" do
  let(:xml) do
    '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <svg xmlns:dc="http://purl.org/dc/elements/1.1/">
    <metadata><rdf:RDF>
    <dc:title>Test Presentation</dc:title>
    </rdf:RDF></metadata>
    <g class="waypoints">
    <rect class="">
    <title>A Title</title>
    </rect>
    </g>
    </svg>'
  end
end
