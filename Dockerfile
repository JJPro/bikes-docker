# Build Bike Plugin
FROM composer AS plugin_builder
WORKDIR /app/
RUN git clone https://github.com/JJPro/bike-sharing-plugin.git .
RUN composer install && composer dump-autoload -o

# Build bike theme
FROM node:14 AS theme_builder
WORKDIR /app/
RUN git clone https://github.com/JJPro/bike-sharing-theme.git .
RUN npm i && npm run build



# Final Image 
FROM bitnami/wordpress-nginx

# Copy build artifacts from early stages
WORKDIR /bikes/plugin/
COPY --from=plugin_builder /app/lib ./lib
COPY --from=plugin_builder /app/vendor ./vendor
COPY --from=plugin_builder /app/*.php ./
WORKDIR /bikes/theme/
COPY --from=theme_builder /app/dist ./dist
COPY --from=theme_builder /app/style.css ./
COPY --from=theme_builder /app/*.php ./
