# -*- coding: utf-8 -*-
require 'method_source'

module TableBeet
  class Step
    attr_reader :name, :file, :lineno

    def initialize(method)
      @method = method
      @name   = method.name.to_s
      @file, @lineno = method.source_location
      @file = File.expand_path(@file)
    end

    def id
      @method.hash
    end

    def source
      @method.comment + @method.source
    end
  end
end
