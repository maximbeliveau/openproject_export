# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require 'open_project/export/version'

Gem::Specification.new do |s|
  s.name        = 'openproject-export'
  s.version     = OpenProject::Export::VERSION
  s.authors     = 'OpenProject GmbH'
  s.email       = 'info@openproject.org'
  s.homepage    = 'https://www.openproject.org'
  s.summary     = 'OpenProject Backup Plugin'
  s.description = 'Allows creating a zipped backup for a project'
  s.license     = 'GPLv3'

  s.files = Dir['{config,lib,app}/**/*'] + %w(CHANGELOG.md README.md)

  s.add_dependency 'rails', '~> 8.0'
  s.add_dependency 'rubyzip', '~> 2.3'
end
