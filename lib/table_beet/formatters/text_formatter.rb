require 'table_beet/formatters/base_formatter.rb'

module TableBeet
  module Formatters
    class TextFormatter < BaseFormatter
      def flush
        @scopes.each do |name, steps|
          puts name
          steps.each do |step|
            puts "- #{step.name}\tfile://#{step.file}:#{step.lineno}"
          end
          puts
        end
      end
    end
  end
end
