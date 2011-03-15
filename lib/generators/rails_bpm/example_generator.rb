module RailsBpm
  module Generators
    class ExampleGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates an example process."
      
      def copy_example
        directory "app"
      end
    end
  end
end