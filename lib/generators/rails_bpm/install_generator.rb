module RailsBpm
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a RailsBpm config files and copy it to your application."
      
      def make_dirs
        empty_directory "app/processes"
        empty_directory "app/participants"
      end
      
      def copy_password
        template "password", "config/password"
      end
      def copy_public
        directory "public"
      end
    end
  end
end