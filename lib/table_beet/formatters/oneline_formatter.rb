require 'table_beet/formatters/base_formatter.rb'

module TableBeet
  module Formatters
    class OnelineFormatter < BaseFormatter
      def flush
        @scopes.each do |name, steps|
          steps.each do |step|
            puts "[@#{name}] #{step.name} at:#{step.file}:#{step.lineno}"
          end
        end
      end
    end
  end
end
