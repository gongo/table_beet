require 'table_beet/reporter'

module TableBeet
  class Runner
    def initialize(config)
      @files = config[:files]
      @config = config.to_hash
    end

    def run
      TableBeet::Loader.load(load_files)
      TableBeet::Reporter.build(@config)
    end

    def load_files
      Dir.glob(@files)
    end
  end

  class Loader
    def self.load(files)
      # https://github.com/jnicklas/turnip#where-to-place-steps
      files.each { |f| Kernel.load f, true }
    end
  end
end
