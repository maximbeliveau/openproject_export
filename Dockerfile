FROM openproject/openproject:16 AS plugin

# If installing a local plugin (using `path:` in the `Gemfile.plugins` above),
# you will have to copy the plugin code into the container here and use the
# path inside of the container. Say for `/app/vendor/plugins/openproject-slack`:
# COPY /path/to/my/local/openproject-slack /app/vendor/plugins/openproject-slack

COPY Gemfile.plugins /app/
COPY openproject-export /app/plugins/openproject-export

# If the plugin uses any external NPM dependencies you have to install them here.
# RUN npm add npm <package-name>*

RUN bundle config unset deployment
RUN bundle install
RUN bundle config set deployment 'true'
RUN ./docker/prod/setup/precompile-assets.sh

FROM openproject/openproject:16-slim

COPY --from=plugin /usr/bin/git /usr/bin/git
COPY --chown=$APP_USER:$APP_USER --from=plugin /app/vendor/bundle /app/vendor/bundle
COPY --chown=$APP_USER:$APP_USER --from=plugin /usr/local/bundle /usr/local/bundle
COPY --chown=$APP_USER:$APP_USER --from=plugin /app/public/assets /app/public/assets
COPY --chown=$APP_USER:$APP_USER --from=plugin /app/config/frontend_assets.manifest.json /app/config/frontend_assets.manifest.json
COPY --chown=$APP_USER:$APP_USER --from=plugin /app/Gemfile.* /app/
