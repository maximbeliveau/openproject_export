module OpenProject
  module Export
    class Hooks < OpenProject::Hook::ViewListener
      render_on :view_projects_settings_menu,
                partial: 'open_project/export/hooks/backup_button'
    end
  end
end

