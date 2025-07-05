# OpenProject Export Plugin

In this plugin we try to give you an idea on how to write an OpenProject plugin. Examples of doing the most common things a plugin may want to do are included.

To get started quickly you may just copy this plugin, remove the bits you don't need and modify/add the features you want.


## Pre-requisites

In order to be able to continue, you will first have to have a working OpenProject core development environment. Please follow these guides to set that up:

* [Development environment Ubuntu/Debian](https://www.openproject.org/docs/development/development-environment-ubuntu/)
* [Development environment Mac OS X](https://www.openproject.org/docs/development/development-environment-osx/)
* [Development environment Docker](https://www.openproject.org/docs/development/development-environment-docker/)

We are assuming that you understand how to develop Ruby on Rails applications and are familiar with controllers, views, asset management, hooks and engines.

To get started with a development environment of the OpenProject core, we recommend you follow our development guides at https://docs.openproject.org/development/ as well as the [guide for plugin development](https://www.openproject.org/docs/development/create-openproject-plugin).

The frontend can be written using plain-vanilla JavaScript, but if you choose to integrate directly with the OpenProject frontend then you will have to understand the Angular framework.


## Getting started

To include this plugin, you need to create a file called `Gemfile.plugins` in your OpenProject core directory with the following contents:

```
group :opf_plugins do
  gem "openproject-export", git: "https://github.com/opf/openproject-export.git", branch: "dev"
end
```

As you may want to play around with and modify the plugin locally, you may want to check it out first and use the following instead to reference a local path:

```
group :opf_plugins do
  gem "openproject-export", path: "/path/to/openproject-export"
end
```

If you already have a `Gemfile.plugins` just add the line "gem" line to it inside the `:opf_plugins` group.

Once you've done that, **switch to the OpenProject core directory** and run:

```bash
./bin/setup_dev
```

While you're in the root of the OpenProject core, we recommend you export the OpenProject core path as `$OPENPROJECT_ROOT`.

```bash
export OPENPROJECT_ROOT=$(pwd)
```

This will make the plugin known to the OpenProject core with bundler and optionally link a frontend directory into the core (more on that later).

Optionally, you might want to run plugin seeds, if there are any:

```bash
bundle exec rails db:seed # creates default data from the plugin's seeder (`app/seeders`)
```

You can then start the core server as described in the above guides. For example, you can then start the rails server with:

```bash
RAILS_ENV=development ./bin/rails server
```

As well as the Angular CLI in development mode with:

```bash
RAILS_ENV=development npm run serve
```

In order to verify that the plugin has been installed correctly, go to the Administration Plugins Page at http://localhost:3000/admin/plugins and you should be able to find your plugin in the list.


In the following sections we will explain some common features that you may want to use in your own plugin. This plugin has already been setup with the basic framework to illustrate all these features.

Each section will list the relevant files you may want to look at and explain the features. Beyond that there are also code comments in the respective files which provide further details.

### Frontend linking
This proto plugin contains an Angular frontend part. The way the Angular CLI works, it needs to build the project from a common root folder. That is located at `$OPENPROJECT_ROOT/frontend`.

To make your plugin's frontend available to the OpenProject core, it is being symlinked into `$OPENPROJECT_CORE/frontend/src/app/features/plugins/linked/your-plugin-name`. This is being done by the `bin/setup_dev` script, which needs to run whenever you add or remove a plugin from your Gemfile.

Working with this symlinked frontend is a bit tricky. What we recommend is that you develop your Ruby backend in the plugin folder, while you develop the Angular frontend in the OpenProject core. This way, you will get all benefits from the CLI and language services such as auto-completion, angular generations, correct paths being looked up by Typescript, etc.

JS files in `/frontend` import other modules in the core app with the `core-app/` prefix which is an alias pointing to `<core-app-root>/frontend/src/app` defined in the `tsconfig.base.json` file, be careful to update import path when configurations change. You will get error outputs from your angular CLI however.

### Rails generators

The plugin comes with an executable `bin/rails` which you can use when calling rails generators for generating everything. You will have to define `OPENPROJECT_ROOT` in your environment for it to work unfortunately, because the plugin requires the core to load.

By `core` we mean the directory under which you originally checked out the OpenProject repository:

```
$ git clone https://github.com/opf/openproject.git ~/dev/openproject/core
$ git checkout dev
```

So for example, should the core be located under under `~/dev/openproject/core` you can set it like this, for instance in your `.bashrc`:

```
export OPENPROJECT_ROOT=~/dev/openproject/core
```

or you can just prepend the relevant rails commands like this:

```
$ OPENPROJECT_ROOT=~/dev/openproject/core rails generate ...
```

Once you've set that up you can use the rails generators as usual.

## Attachments export

This plugin contains a small feature to download all attachments of the current project.
Once enabled, you will find a new entry under **Project settings**. Clicking this
"Export attachments" link will create a ZIP archive with all attachments of that
project and start the download.

Relevant files:

* `app/controllers/attachments_export_controller.rb` - Collects attachments and streams the ZIP file
* `config/routes.rb` - Adds the `attachments_export` route
* `lib/open_project/export/engine.rb` - Registers the permission and menu entry


You can add nested menu items by passing a `parent` option to the following items.

There are a number of menus available from which to choose:

* top_menu
* account_menu
* application_menu
* my_menu
* admin_menu
* project_menu


## Homescreen Blocks

By default the homepage contains a number of blocks (widget boxes), namely: "Projects", "Users", "My account", "OpenProject community" and "Administration".

You can easily add your own user-defined block so that it will also appears on the homepage.

The relevant files for homescreen blocks are:

* `lib/open_project/export/engine.rb` - `export.homescreen_blocks` initializer
* `app/views/homescreen/blocks/_homescreen_block.html.erb`

In the file `engine.rb` you can register additional blocks in OpenProject's homescreen like this:

```
initializer 'export.homescreen_blocks' do
  OpenProject::Static::Homescreen.manage :blocks do |blocks|
    blocks.push(
      { partial: 'homescreen_block', if: Proc.new { true } }
    )
  end
end
```

Where the `if` option is optional.

The partial file `_homescreen_block.html.erb` provides the template from which the contents of the block will be generated. Have a look at this file to get a better idea of the possibilities.

This is what you should now see on the homepage:



## OpenProject::Notification listeners

The relevant files for notification listeners are:

* `lib/open_project/export/engine.rb` - `export.notifications` initializer

Although OpenProject has inherited hooks (see next section) from Redmine, it also employs its own mechanism for simple event callbacks. Their return values are ignored.

For example, you can be notified whenever a user has been invited to OpenProject by subscribing to the `user_invited` event. Add the following to the `engine.rb` file:

```
initializer 'export.notifications' do
  OpenProject::Notifications.subscribe 'user_invited' do |token|
    user = token.user

    Rails.logger.debug "#{user.email} invited to OpenProject"
  end
end
```


### Events

Currently the supported events (_block parameters in parenthesis_) to which you can subscribe are:

* user_invited (token)
* user_reinvited (token)
* project_updated (project)
* project_renamed (project)
* project_deletion_imminent (project)
* member_updated (member)
* member_removed (member)
* journal_created (payload)
* watcher_added (payload)


### Setting Events

Whenever a given setting changes, an event is triggered passing the previous and new values. For instance:

* `setting.host_name.changed` (value, old_value)

Where `host_name` is the name of the setting. You can find out all setting names simply by inspecting the relevant setting input field in the admin area in your browser or by listing them all on the rails console through `Setting.pluck(:name)`. Also have a look at `config/settings.yml` where all the default values for settings are defined by their name.


## Hooks

The relevant files for hooks are:

* `lib/open_project/engine.rb` - `export.register_hooks` initializer
* `lib/open_project/hooks.rb`
* `app/views/hooks/export/_homescreen_after_links.html.erb`
* `app/views/hooks/export/_view_layouts_base_sidebar.html.erb`

Hooks can be used to extend views, controllers and models at certain predefined places. Each hook has a name for which a method has to be defined in your hook class, see `lib/open_project/export/hooks.rb` for more details.

For example:

```
render_on :homescreen_after_links, partial: '/hooks/homescreen_after_links'
```

By using `render_on`, the given variables are made available as locals to the partial for that defined hook. Otherwise they will be available through the defined hook method's first and only parameter named `context`.

Additionally the following context information is put into context if available:

* project - current project
* request - Request instance
* controller - current Controller instance
* hook_caller - object that called the hook


### View Hooks

_Note: context variables placed within (parenthesis)_

Hooks in the base template:

* :view_layouts_base_html_head
* :view_layouts_base_sidebar
* :view_layouts_base_breadcrumb
* :view_layouts_base_content
* :view_layouts_base_body_bottom

More hooks:

* :view_account_login_auth_provider
* :view_account_login_top
* :view_account_login_bottom
* :view_account_register_after_basic_information (f) - f being a form helper
* :activity_index_head
* :view_admin_info_top
* :view_admin_info_bottom
* :view_common_error_details (params, project)
* :homescreen_administration_links
* :view_work_package_overview_attributes

Custom field form hooks:

* :view_custom_fields_form_upper_box (custom_field, form)
* :view_custom_fields_form_work_package_custom_field (custom_field, form)
* :view_custom_fields_form_user_custom_field (custom_field, form)
* :view_custom_fields_form_group_custom_field (custom_field, form)
* :view_custom_fields_form_project_custom_field (custom_field, form)
* :view_custom_fields_form_time_entry_activity_custom_field (custom_field, form)
* :view_custom_fields_form_version_custom_field (custom_field, form)
* :view_custom_fields_form_issue_priority_custom_field (custom_field, form)


### Controller Hooks

_Note: context variables placed within (parenthesis)_

* :controller_account_success_authentication_after (user)
* :controller_custom_fields_new_after_save (custom_field)
* :controller_custom_fields_edit_after_save (custom_field)
* :controller_messages_new_after_save (params, message)
* :controller_messages_reply_after_save (params, message)
* :controller_timelog_available_criterias (available_criterias, project)
* :controller_timelog_time_report_joins (sql)
* :controller_timelog_edit_before_save (params, time_entry)
* :controller_wiki_edit_after_save (params, page)
* :controller_work_packages_bulk_edit_before_save (params, work_package)
* :controller_work_packages_move_before_save (params, work_package, target_project, copy)


### More Hooks

_Note: context variables placed within (parenthesis)_

* :model_changeset_scan_commit_for_issue_ids_pre_issue_update (changeset, issue)
* :copy_project_add_member (new_member, member)
