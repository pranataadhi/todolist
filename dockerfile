# Dockerfile
FROM php:8.2-apache

# Install PHP ekstensi dan Composer
RUN apt-get update && apt-get install -y \
    zip unzip git curl libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy semua file Laravel ke container
COPY . .

# Install Laravel dependencies
RUN composer install --no-interaction --optimize-autoloader

# Set folder permission
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

EXPOSE 8000

# Jalankan Laravel dengan PHP built-in server
CMD php artisan serve --host=0.0.0.0 --port=8000
