module OpenProject
  module Export
    # Load Redmine I18n before OpenProject's hook system to avoid
    # uninitialized constant errors during plugin initialization.
    require 'redmine/i18n'
    require 'open_project/hook'
    class Hooks < OpenProject::Hook::ViewListener
      render_on :view_projects_settings_menu,
                partial: 'open_project/export/hooks/download_all_button'
    end
  end
end
