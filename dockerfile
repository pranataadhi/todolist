# Gunakan base image PHP dengan Apache
FROM php:8.2-apache

# Install dependensi yang dibutuhkan Laravel dan SQLite
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev zip sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite zip

# Salin Laravel app ke container
COPY . /var/www/html

# Ubah workdir
WORKDIR /var/www/html

# Tambahkan Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install dependencies Laravel
RUN composer install --no-interaction --prefer-dist

# Siapkan file .env dan generate key
RUN cp .env.example .env && \
    php artisan key:generate && \
    chown -R www-data:www-data /var/www/html

# Buka port 8000
EXPOSE 8000

# Jalankan Laravel menggunakan built-in PHP server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
