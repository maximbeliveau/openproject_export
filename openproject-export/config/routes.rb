Rails.application.routes.draw do
  get "/projects/:project_id/backup",
      to: "open_project/export/backups#download",
      as: "backup_project"
end

