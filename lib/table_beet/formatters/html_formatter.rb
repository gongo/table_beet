# -*- coding: utf-8 -*-

require 'table_beet/formatters/base_formatter.rb'
require 'erb'

module TableBeet
  module Formatters
    class HTMLFormatter < BaseFormatter
      def flush
        create_index
        create_metadata_dir
      end

      private

        def create_index
          erb = ERB.new(File.read(template_output))
          scope_names = @scopes.keys
          scopes = @scopes

          File.open(output, 'w') do |f|
            f.write erb.result(binding)
          end
        end

        def create_metadata_dir
          FileUtils.copy_entry(template_metadata_dir, @directory)
        end

        def template_dir
          File.dirname(__FILE__) + '/html_template'
        end

        def template_output
          template_dir + '/index.erb'
        end

        def template_metadata_dir
          template_dir + '/data'
        end

        def output
          @directory + '/index.html'
        end

        def metadata_dir
          @directory + '/data'
        end
    end
  end
end
