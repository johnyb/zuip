require 'spec_helper'
require 'zuip/outline'

describe "An Outline" do
  let(:xml) do
    '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <svg xmlns:dc="http://purl.org/dc/elements/1.1/">
    <metadata><rdf:RDF>
    <dc:title>Test Presentation</dc:title>
    </rdf:RDF></metadata>
    <g id="waypoints" class="waypoints">
      <g class="head1">
        <use xlink:href="#waypoint" transform="translate(200,80) scale(0.8)" />
        <title>Title</title>
      </g>
      <g class="head1">
        <use xlink:href="#waypoint" transform="translate(-70,300) scale(0.23)" />
        <title>Slides</title>
        <g class="head2">
          <use xlink:href="#waypoint" transform="translate(-70,460) scale(0.23)" />
          <title>Advantages</title>
        </g>
        <g class="head2">
          <use xlink:href="#waypoint" transform="translate(-40,690) scale(0.23)" />
          <title>Problems</title>
        </g>
      </g>
      <g class="head1">
        <use xlink:href="#waypoint" transform="translate(475,290) scale(0.27)" />
        <title>ZUI Presentations</title>
        <g class="head2">
          <use xlink:href="#waypoint" transform="translate(475,460) scale(0.33)" />
          <title>Advantages</title>
        </g>
        <g class="head2">
          <use xlink:href="#waypoint" transform="translate(445,690) scale(0.25)" />
          <title>Problems</title>
        </g>
      </g>
      <g class="head1">
        <use xlink:href="#waypoint" transform="translate(250,-100) scale(0.9)" />
        <title>Solutions</title>
        <g class="head2">
          <use xlink:href="#waypoint" transform="translate(-200,-150) scale(0.23)" />
          <title>Prezi</title>
        </g>
        <g class="head2">
          <use xlink:href="#waypoint" transform="translate(250,-150) scale(0.23)" />
          <title>CounterPoint</title>
        </g>
        <g class="head2">
          <use xlink:href="#waypoint" transform="translate(150,0) scale(2)" />
          <title>ZUIP</title>
        </g>
      </g>
    </g>
    </svg>'
  end
end
