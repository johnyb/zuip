module ZUIP
  class Presentation
    attr_accessor :title
    attr_reader :outline

    def outline=(o)
      raise ArgumentException unless o.class == Array
      @outline = o
    end
  end
end

