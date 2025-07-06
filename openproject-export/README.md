# OpenProject Export Plugin

This plugin adds a **Backup Project** entry to the project settings sidebar. Selecting it downloads a zipped archive containing the project's attachments.

## Usage
Add the plugin to `Gemfile.plugins` of your OpenProject installation:
```ruby
group :opf_plugins do
  gem 'openproject-export', path: '/path/to/openproject-export'
end
```

After adding it, run `./bin/setup_dev` from your OpenProject core directory and start the server as usual.


Run `bundle exec rake spec` from this directory or the repository root to execute the plugin's test suite.

