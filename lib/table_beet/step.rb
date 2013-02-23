# -*- coding: utf-8 -*-

module TableBeet
  class Step
    attr_reader :name, :file, :lineno

    def initialize(method)
      @name = method.name.to_s
      @file, @lineno = method.source_location
      @file = File.expand_path(@file)
    end
  end
end
