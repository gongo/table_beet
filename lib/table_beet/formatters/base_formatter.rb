module TableBeet
  module Formatters
    class BaseFormatter
      attr_reader :scopes, :directory

      def initialize(scopes, directory)
        @scopes = scopes
        @directory = directory
      end
    end
  end
end
