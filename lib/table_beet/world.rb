require 'turnip'

module TableBeet
  class World
    #
    # @return  [Hash]  The hash that { scope name => Array of ::TableBeet:Step }
    #
    def self.scopes
      scopes = Hash.new {|hash, key| hash[key] = []}

      RSpec.configuration.include_or_extend_modules.each do |_, mod, tags|
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
