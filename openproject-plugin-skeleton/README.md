# OpenProject Plugin Skeleton

This folder provides a minimal skeleton to start developing a new OpenProject plugin.

## Usage

1. Copy this directory to your plugin's name, e.g. `openproject-my_plugin`.
2. Update `openproject-plugin-skeleton.gemspec` and files under `lib/` to reflect your plugin name.
3. Add the plugin to `Gemfile.plugins` of your OpenProject installation:

```ruby
group :opf_plugins do
  gem 'openproject-my_plugin', path: '/path/to/openproject-my_plugin'
end
```

4. From the OpenProject core directory run:

```bash
./bin/setup_dev
```

This will install the plugin and link assets. Start the server as usual with `./bin/rails server`.

For more information see the [OpenProject plugin guide](https://www.openproject.org/docs/development/create-openproject-plugin/).
