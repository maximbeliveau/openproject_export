module OpenProject
  module Export
    require "open_project/export/engine"
    begin
      require "open_project/export/hooks"
    rescue LoadError => e
      warn "OpenProject::Export::Hooks could not be loaded: #{e.class} #{e.message}"
    end
  end
end
