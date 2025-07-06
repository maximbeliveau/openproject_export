module OpenProject
  module Export
    require 'redmine/i18n'
    begin
      require 'open_project/hook'
    rescue StandardError
      module ::OpenProject
        module Hook
          class ViewListener
            def self.render_on(*); end
          end
        end
      end
    end
    class Hooks < OpenProject::Hook::ViewListener
      render_on :view_projects_settings_menu,
                partial: 'open_project/export/hooks/download_all_button'
    end
  end
end
