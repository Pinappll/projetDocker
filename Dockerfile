FROM php:8.1-fpm-alpine

WORKDIR /var/www/html

# Installation de composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Installation des composants php
RUN docker-php-ext-install pdo pdo_mysql

# Installation de Node.js et npm
RUN apk add --update nodejs npm

# Copyie du code source dans le conteneur
COPY . /var/www/html

# Rend le script exécutable
RUN chmod +x /var/www/html/script.sh

