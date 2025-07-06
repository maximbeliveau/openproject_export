module OpenProject
  module Export
    begin
      require 'open_project/hook'
    rescue StandardError
      module ::OpenProject
        module Hook
          class ViewListener
            def self.render_on(*) = nil
          end
        end
      end
    end

    unless defined?(Redmine::I18n)
      module ::Redmine
        module I18n
          def l(key, default: nil, **)
            default || key.to_s
          end

          def current_language
            :en
          end

          def self.included(base)
            base.extend self
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
