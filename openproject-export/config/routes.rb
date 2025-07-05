Rails.application.routes.draw do
  scope '', as: 'export_plugin' do
    scope 'projects/:project_id', as: 'project' do
      get 'attachments_export', to: 'attachments_export#download', as: 'attachments_export'
    end
  end
end
