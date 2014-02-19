require 'table_beet/world'
require 'table_beet/formatters/text_formatter'
require 'table_beet/formatters/oneline_formatter'
require 'table_beet/formatters/html_formatter'

module TableBeet
  class Reporter
    #
    # @param  [Hash]  config
    #                   :format => [Symbol] Output format
    #                                         :t or :text is plain text
    #                                         otherwise HTML
    #
    #                   :output => [String] Directory to output'
    #
    def self.build(config = {})
      type   = config[:format]
      output = config[:output] || './stepdoc'
      formatter(type).new(TableBeet::World.scopes, output).flush
    end

    def self.formatter(type)
      case type
      when :t, :text
        TableBeet::Formatters::TextFormatter
      when :s, :oneline
        TableBeet::Formatters::OnelineFormatter
      else
        TableBeet::Formatters::HTMLFormatter
      end
    end
  end
end
