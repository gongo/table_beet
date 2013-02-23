require 'table_beet/world'
require 'table_beet/formatters/text_formatter'
require 'table_beet/formatters/html_formatter'

module TableBeet
  class Reporter
    def self.build(config)
      type   = config[:format]
      output = config[:output]
      formatter(type).new(TableBeet::World.scopes, output).flush
    end

    def self.formatter(type)
      case type
      when 't'
        TableBeet::Formatters::TextFormatter
      else
        TableBeet::Formatters::HTMLFormatter
      end
    end
  end
end
