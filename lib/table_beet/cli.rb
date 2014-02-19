require 'table_beet/version'
require 'table_beet/runner'
require 'slop'

module TableBeet
  class CLI
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
          on :output=, 'Directory to output (default: ./stepdoc)'
          on :path=,   'Directory that contains step file. (default: ./spec)'
          on :suffix=, 'Suffix of step file  (default: _steps.rb)'
          on :n, :textmode, 'Display steps in plain text (No generate HTML)'
          on :s, :oneline, 'Display steps in plain text (short mode)'
          on :v, :version, 'Print this version' do
            puts TableBeet::VERSION
            exit
          end
        end

        exit if opts.present?(:help)

        opts.to_hash.tap do |h|
          h.delete(:help)
          h.delete(:version)

          h[:format] = :text if opts.textmode?
          h[:format] = :oneline if opts.oneline?
        end
      end
  end
end
