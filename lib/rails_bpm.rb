# RailsBpm
require 'ruote-kit'
require 'rails_bpm/process'
require 'rails_bpm/model'
require 'rails_bpm/participant'
require 'formtastic'
require 'will_paginate'

module RailsBpm
  class Engine < Rails::Engine
    initializer ":rails_bpm_engine.add_rootkit" do |app|
      require 'rack/ruote_admin_only'
      app.middleware.use Rack::RuoteAdminOnly
      
      Dir.glob(Rails.root.join('app/processes/*.rb')).each do |proc_class|
        require proc_class
      end
      
      Dir.glob(Rails.root.join('app/participants/*.rb')).each do |partic_class|
        require partic_class
      end

      require 'ruote_kit_init'

    end
  end
  def self.register_participants
    Participant._register_all
    Process._register_participants
  end
end