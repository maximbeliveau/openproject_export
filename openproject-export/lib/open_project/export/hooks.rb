module OpenProject
  module Export
    require 'open_project/hook'
    class Hooks < OpenProject::Hook::ViewListener
      render_on :view_projects_settings_menu,
                partial: 'open_project/export/hooks/download_all_button'
    end
  end
end
