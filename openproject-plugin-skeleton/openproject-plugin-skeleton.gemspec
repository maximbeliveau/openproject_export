# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require 'open_project/plugin_skeleton/version'

Gem::Specification.new do |s|
  s.name        = 'openproject-plugin-skeleton'
  s.version     = OpenProject::PluginSkeleton::VERSION
  s.authors     = 'OpenProject GmbH'
  s.email       = 'info@openproject.org'
  s.homepage    = 'https://www.openproject.org'
  s.summary     = 'OpenProject Plugin Skeleton'
  s.description = 'A minimal skeleton for creating an OpenProject plugin'
  s.license     = 'GPLv3'

  s.files = Dir['{config,lib}/**/*'] + %w(CHANGELOG.md README.md)

  s.add_dependency 'rails', '>= 8.0.1'
end
