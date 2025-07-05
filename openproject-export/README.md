# OpenProject Export Plugin

This plugin adds a simple action to download all attachments of a project as a ZIP archive.

## Installation

Add the plugin to your `Gemfile.plugins` inside the `:opf_plugins` group:

```ruby
gem "openproject-export", path: "../openproject-export"
```

Run `bundle install` from the OpenProject root to load the plugin.

## Usage

Open **Project settings** for any project. A new sidebar entry **Export attachments** will appear. Clicking it streams a ZIP file containing all attachments of the current project.

## Implementation

* `app/controllers/attachments_export_controller.rb` – collects attachments and creates the archive
* `config/routes.rb` – defines the `/projects/:project_id/attachments_export` route
* `lib/open_project/export/engine.rb` – registers the permission and menu item

