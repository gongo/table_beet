require 'table_beet/reporter'
require 'table_beet/loader'

module TableBeet
  class Runner
    def initialize(config = {})
      @config = config
    end

    def run
      loader = TableBeet::Loader.new(@config)
      number_of_load = loader.load

      # TOOD logger..?
      if number_of_load.zero?
        puts "[warn] There are no loaded file with specified option."
        puts "    finder => #{loader.display_pattern}"
      end

      TableBeet::Reporter.build(@config)
    end
  end
end
