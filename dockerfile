# Gunakan base image PHP + Apache
FROM php:8.2-apache

# Install ekstensi Laravel
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev zip \
    && docker-php-ext-install pdo pdo_mysql zip

# Salin Laravel ke dalam container
COPY . /var/www/html

# Pindah ke folder Laravel
WORKDIR /var/www/html

# Install Composerr
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
RUN composer install --no-interaction --prefer-dist

# Ubah permission & file .env
RUN chown -R www-data:www-data /var/www/html \
    && cp .env.example .env \
    && php artisan key:generate

EXPOSE 8000

# Jalankan Laravel dengan PHP built-in server
CMD php artisan serve --host=0.0.0.0 --port=8000
