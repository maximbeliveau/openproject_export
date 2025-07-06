# OpenProject Export Plugin
This plugin also adds a "Backup Project" button to create a zipped backup of the project.
## Usage
Add the plugin to `Gemfile.plugins` of your OpenProject installation:
```ruby
group :opf_plugins do
  gem 'openproject-export', path: '/path/to/openproject-export'
end
```
After adding it, run `./bin/setup_dev` from your OpenProject core directory and start the server normally.
Run `bundle exec rake spec` from this directory or the repository root to execute the plugin's test suite.