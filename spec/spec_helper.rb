require 'table_beet'
require 'coveralls'
Coveralls.wear!

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/steps'
OUTPUT_PATH = File.dirname(__FILE__) + '/stepdoc'

if RSpec::Core::Version::STRING >= '3.2.0'
  require 'rspec/core/sandbox'
else
  require 'rspec/core'

  # See: https://github.com/rspec/rspec-core/blob/v3.2.2/lib/rspec/core/sandbox.rb
  module RSpec

    class << self
      # For RSpec 3.1.x
      attr_writer :configuration, :world unless RSpec.respond_to?(:configuration=)
    end

    module Core
      module Sandbox
        def self.sandboxed
          orig_config  = RSpec.configuration
          orig_world   = RSpec.world

          RSpec.configuration = RSpec::Core::Configuration.new
          RSpec.world         = RSpec::Core::World.new(RSpec.configuration)

          yield RSpec.configuration
        ensure
          RSpec.configuration = orig_config
          RSpec.world         = orig_world
        end
      end
    end
  end
end

RSpec.configure do |c|
  c.around(:each) do |ex|
    #
    # Reset the added steps
    #   on https://github.com/jnicklas/turnip/blob/v1.2.4/lib/turnip/dsl.rb#L21
    #
    RSpec::Core::Sandbox.sandboxed do |config|
      #
      # Sandbox config does not included Turnip::Steps yet.
      #
      config.include Turnip::Steps, turnip: true

      ex.run

      #
      # Reset the addes 'global' steps
      #
      Turnip::Steps.instance_methods.each do |method|
        Turnip::Steps.module_eval { undef_method method }
      end
    end
  end
end
