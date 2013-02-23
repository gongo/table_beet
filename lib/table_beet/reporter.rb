require 'table_beet/world'
require 'table_beet/formatters/text_formatter'
require 'table_beet/formatters/html_formatter'

module TableBeet
  class Reporter
    #
    # @param  [Hash]  config
    #                   :format => [String] Output format
    #                                         't' or 'text' is plain text
    #                                         'h' or 'html' is HTML
    #
    #                   :output => [String] Output directory path (glob pattern)
    #                                       Only valid for 'html' format
    #
    def self.build(config = {})
      type   = config[:format]
      output = config[:output]
      formatter(type).new(TableBeet::World.scopes, output).flush
    end

    def self.formatter(type)
      case type
      when 't', 'text'
        TableBeet::Formatters::TextFormatter
      when 'h', 'html'
        TableBeet::Formatters::HTMLFormatter
      else
        TableBeet::Formatters::HTMLFormatter
      end
    end
  end
end
