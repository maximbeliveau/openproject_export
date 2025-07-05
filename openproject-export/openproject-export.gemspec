# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require 'open_project/export/version'
# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "openproject-export"
  s.version     = OpenProject::Export::VERSION
  s.authors     = "OpenProject GmbH"
  s.email       = "info@openproject.org"
  s.homepage    = "https://community.openproject.org/projects/export-plugin"  # TODO check this URL
  s.summary     = 'OpenProject Export Plugin'
  s.description = "A prototypical OpenProject plugin"
  s.license     = "GPLv3"

  s.files = Dir["{app,config,db,lib}/**/*"] + %w(CHANGELOG.md README.md)

  s.add_dependency "rails", '>= 8.0.1'
end
