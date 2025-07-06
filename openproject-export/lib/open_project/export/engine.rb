require 'active_support/dependencies'
require 'open_project/plugins'

module OpenProject
  module Export
    class Engine < ::Rails::Engine
      engine_name :openproject_export

      include OpenProject::Plugins::ActsAsOpEngine

      register 'openproject-export',
               author_url: 'https://openproject.org',
               requires_openproject: '>= 13.1.0'

      initializer 'openproject-export.register_hooks' do
        begin
          ::OpenProject::Export::Hooks
        rescue NameError
          # Hooks not loaded (missing OpenProject core)
        end
      end
    end
  end
end
