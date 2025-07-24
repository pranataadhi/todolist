FROM php:8.2-cli

# Install system dependencies dan ekstensi PHP yang dibutuhkan Laravel
RUN apt-get update && apt-get install -y \
    git unzip zip libzip-dev libpng-dev libonig-dev curl \
    && docker-php-ext-install pdo pdo_mysql zip mbstring

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy seluruh isi repo ke dalam image
COPY . /var/www/html
WORKDIR /var/www/html

# Install Laravel dependencies
RUN composer install --no-interaction --prefer-dist

# Salin .env, generate key, link storage, dan set permission
RUN cp .env.example .env \
    && php artisan key:generate \
    && php artisan storage:link \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Laravel dijalankan pada port 8000
EXPOSE 8000

# Jalankan Laravel dengan built-in server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
