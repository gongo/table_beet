module TableBeet
  module Formatters
    class BaseFormatter
      def initialize(scopes, directory)
        @scopes = scopes
        @directory = directory
      end
    end
  end
end
