require 'table_beet/version'
require 'table_beet/runner'
require 'slop'

module TableBeet
  class CLI
    USE_OPTIONS = {
      o: [:output, 'Output directory when choose "h" format', 'spec/step_document' ],
      s: [:files,  'Check step files', 'spec/steps/**/*steps.rb' ],
      f: [:format, 'Choose a formatter [t]ext [j]son [h]tml', 't'],
    }

    def initialize(opts = nil)
      @runner = TableBeet::Runner.new(opts || parse_options)
    end

    def run
      @runner.run
    end

    def self.run(opts = nil)
      TableBeet::CLI.new(opts).run
    end

    private

      def parse_options
        opts = Slop.parse(help: true, optional_arguments: true) do
          banner 'Usage: table_beet [options]'
          USE_OPTIONS.each do |short, params|
            long, desc, default = params
            on short, long, desc + " (default: '#{default}')", default: default
          end
          on :v, :version, 'Print this version' do
            puts TableBeet::VERSION
            exit
          end
        end

        exit if opts.present?(:help)
        opts
      end
  end
end
