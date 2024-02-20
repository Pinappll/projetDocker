FROM php:8.1-fpm-alpine

WORKDIR /var/www/html

# Install Composer from the official image
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install Node.js and npm
RUN apk add --update nodejs npm

# Copy the entire source code
COPY . /var/www/html

# Assurez-vous que le script est exécutable (à faire si le script n'est pas déjà exécutable)
RUN chmod +x /var/www/html/script.sh

# Note: L'exécution du script install.sh est gérée par docker-compose, donc pas besoin d'ajouter d'autres commandes ici