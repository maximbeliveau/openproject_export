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


## Testing

Run `bundle install` to install the development gems and then execute
`bundle exec rake spec` from this repository root or the plugin
directory. The suite only contains placeholder specs but ensures the
environment is set up correctly.
