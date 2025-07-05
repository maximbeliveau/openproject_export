OpenProject::Export::Engine.routes.draw do
  get '/projects/:project_id/attachments/download_all',
      to: 'attachments#download_all',
      as: 'download_all_project_attachments'
end
