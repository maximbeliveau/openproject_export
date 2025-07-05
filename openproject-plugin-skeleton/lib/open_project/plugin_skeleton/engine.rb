require 'active_support/dependencies'
require 'open_project/plugins'

module OpenProject
  module PluginSkeleton
    class Engine < ::Rails::Engine
      engine_name :openproject_plugin_skeleton

      include OpenProject::Plugins::ActsAsOpEngine

      register 'openproject-plugin-skeleton',
               author_url: 'https://openproject.org',
               requires_openproject: '>= 13.1.0'

      initializer 'openproject-plugin-skeleton.register_hooks' do
        ::OpenProject::PluginSkeleton::Hooks
      end
    end
  end
end
