FROM php:7.4-fpm

# Copy existing application directory contents
COPY . /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    default-mysql-client \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Install extensions
RUN docker-php-ext-install pdo_mysql zip exif pcntl
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install gd

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Start MySQL, Create Test Database
RUN service mysql start && mysql -u root -e "CREATE DATABASE laravel; CREATE USER 'laravel'@'localhost' IDENTIFIED BY 'laravel'; GRANT ALL PRIVILEGES ON *.* TO 'laravel'@'localhost'; FLUSH PRIVILEGES;"

# Set working directory
WORKDIR /var/www

USER $user
