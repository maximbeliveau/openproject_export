# OpenProject Export Plugin

This repository contains the `openproject-export` plugin. It adds a **Backup Project** entry in the project settings sidebar so administrators can download a zipped backup of all project attachments.

## Usage

Include the plugin in your `Gemfile.plugins`:

```ruby
group :opf_plugins do
  gem 'openproject-export', path: '/path/to/openproject-export'
end
```

Run `./bin/setup_dev` inside your OpenProject installation to install dependencies and migrate the database. You can then start the application and access the backup option from a project's *Settings* sidebar.

Run `bundle exec rake spec` from this repository root to execute the plugin's (empty) test suite.
