#!/bin/bash
set -ex

# Plugins 
wp plugin uninstall akismet all-in-one-seo-pack all-in-one-wp-migration amp hello google-analytics-for-wordpress simple-tags 
wp plugin install --activate disable-comments
wp disable-comments settings --types=all
wp disable-comments delete --types=all
ln -s /bikes/plugin /bitnami/wordpress/wp-content/plugins/bike-sharing-plugin
wp plugin activate bike-sharing-plugin

# Themes
ln -s /bikes/theme /bitnami/wordpress/wp-content/themes/bike-sharing-theme
wp theme activate bike-sharing-theme

# Permalink
wp rewrite structure /%category%/%postname%/