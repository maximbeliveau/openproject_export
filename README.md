# OpenProject Export Plugin

This repository contains the `openproject-export` plugin. It adds a **Backup Project** entry in the project settings sidebar so administrators can download a zipped backup of all project attachments.

## Usage

Include the plugin in your `Gemfile.plugins`:

```ruby
group :opf_plugins do
  gem 'openproject-export', path: '/path/to/openproject-export'
end
```

Run `./bin/setup_dev` inside your OpenProject installation to install dependencies and migrate the database.

After starting the application, enable the **Export Backups** module under *Project settings → Modules* so the *Backup Project* button appears in the sidebar.

You can then access the backup option from a project's *Settings* sidebar.

Run `bundle install` and then `bundle exec rake spec` from this repository root to execute the plugin's (currently empty) test suite.
