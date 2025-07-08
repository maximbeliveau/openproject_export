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
        project_module :export_backups do
          permission :download_project_backup,
                     { 'open_project/export/backups' => [:download] },
                     permissible_on: [:project]
        end

        menu :project_menu,
             :backup_project,
             { controller: '/open_project/export/backups', action: :download },
             if: ->(project) {
               project.module_enabled?(:export_backups) &&
                 User.current.allowed_to?(:download_project_backup, project)
             },
             caption: :backup_project_name,
             parent: :settings,
             icon: 'download'
      end

    end
  end
end
