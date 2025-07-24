FROM php:8.2-cli

# Install dependency sistem dan ekstensi PHP
RUN apt-get update && apt-get install -y \
    git unzip zip libzip-dev libpng-dev curl \
    && docker-php-ext-install pdo pdo_mysql zip mbstring

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy source code Laravel
COPY . /var/www/html
WORKDIR /var/www/html

# Install Laravel dependencies & konfigurasi awal
RUN composer install --no-interaction --prefer-dist \
    && cp .env.example .env \
    && php artisan key:generate \
    && php artisan storage:link \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Expose port Laravel dev server
EXPOSE 8000

# Jalankan Laravel dengan built-in PHP server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
