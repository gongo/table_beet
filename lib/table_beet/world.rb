require 'rspec/core/version'

module TableBeet
  class World
    #
    # @return  [Hash]  The hash that { scope name => Array of ::TableBeet:Step }
    #
    def self.scopes
      scopes = Hash.new {|hash, key| hash[key] = []}

      include_modules.each do |mod, tags|
        space = Space.new(mod)
        step_names = space.define_steps
        next if step_names.empty?

        scope_name = tags.keys.first

        step_names.each do |name|
          scopes[scope_name] << Step.new(space.method(name))
        end
      end

      scopes
    end

    private

    def self.include_modules
      if RSpec::Core::Version::STRING >= '3.2.0'
        RSpec.configuration.instance_variable_get(:@include_modules).items_and_filters
      else
        RSpec.configuration.include_or_extend_modules.map { |_, mod, tags| [mod, tags] }
      end
    end

      class Space
        def initialize(mod)
          extend(mod)
        end

        def define_steps
          methods.grep(/^match: (?<name>.+)/) { $~[:name] }
        end
      end
  end
end
