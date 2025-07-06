require 'active_support/dependencies'
require 'open_project/plugins'

module OpenProject
  module Export
    class Engine < ::Rails::Engine
      engine_name :openproject_export

      include OpenProject::Plugins::ActsAsOpEngine

      register 'openproject-export',
               author_url: 'https://openproject.org',
               requires_openproject: '>= 13.1.0' do
        menu :project_menu,
             :settings_backup,
             {
               controller: '/open_project/export/backups',
               action: 'download'
             },
             caption: :backup_project_name,
             parent: :settings,
             param: :project_id
      end

    end
  end
end
