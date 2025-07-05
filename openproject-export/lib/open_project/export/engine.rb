# Prevent load-order problems in case openproject-plugins is listed after a plugin in the Gemfile
# or not at all
require 'active_support/dependencies'
require 'open_project/plugins'

module OpenProject::Export
  class Engine < ::Rails::Engine
    engine_name :openproject_export

    include OpenProject::Plugins::ActsAsOpEngine

    register(
      'openproject-export',
      :author_url => 'https://openproject.org',
      :requires_openproject => '>= 13.1.0'
    ) do
      project_module :attachments_export do
        permission :export_attachments,
                   { attachments_export: %i[download] },
                   require: :member
      end

      menu :project_menu,
           :settings_export_attachments,
           { controller: '/attachments_export', action: 'download' },
           parent: :settings,
           param: :project_id,
           caption: 'Export attachments'
    end

    config.to_prepare do
      ::OpenProject::Export::Hooks
    end

    config.after_initialize do
      OpenProject::Static::Homescreen.manage :blocks do |blocks|
        blocks.push(
          { partial: 'homescreen_block', if: Proc.new { true } }
        )
      end
    end

    config.after_initialize do
      OpenProject::Notifications.subscribe 'user_invited' do |token|
        user = token.user

        Rails.logger.debug "#{user.mail} invited to OpenProject"
      end
    end

  end
end
