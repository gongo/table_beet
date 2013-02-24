require 'pathname'

module TableBeet
  class Loader
    def initialize(config = {})
      @suffix = config[:suffix] || '_steps.rb'
      @directory = config[:path] || './spec'
    end

    #
    # @return  Integer  Size of loaded file
    #
    def load
      # https://github.com/jnicklas/turnip#where-to-place-steps
      paths.each { |f| Kernel.load f, true }
      paths.length
    end

    def paths
      Pathname.glob(pattern)
    end

    def display_pattern
      pattern
    end

    private

    def glob
      '**/*' + @suffix
    end

    def pattern
      File.join(@directory, glob)
    end
  end
end
