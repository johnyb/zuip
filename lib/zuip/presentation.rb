module Zuip
  class Presentation
    attr_accessor :title, :path
    attr_reader :outline, :file

    def outline=(o)
      raise ArgumentException unless o.class == Array
      @outline = o
    end

    def path=(p)
      @path = p
      reload
    end

    private
    def reload
      @file = File.new(path)
    end
  end
end

