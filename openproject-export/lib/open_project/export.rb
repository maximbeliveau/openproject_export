module OpenProject
  module Export
    require "open_project/export/engine"
    begin
      require "open_project/export/hooks"
    rescue LoadError
      warn "OpenProject::Export::Hooks could not be loaded"
    end
  end
end
