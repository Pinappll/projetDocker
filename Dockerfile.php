# Utilisez une image officielle PHP
FROM php:8.1-fpm

# Installez les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    unzip \
    libzip-dev \
    libonig-dev \
    nodejs \
    npm

# Installez Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Activez les extensions PHP nécessaires
RUN docker-php-ext-install pdo pdo_mysql zip

# Définissez le répertoire de travail
WORKDIR /var/www/html

# Copiez les fichiers du projet dans le conteneur
COPY . .

# Installez les dépendances du projet
RUN composer install

# Exécutez les commandes supplémentaires nécessaires
RUN php artisan key:generate


# Installez les dépendances Node.js
RUN npm install -g create-vite
RUN create-vite my-vite-app
WORKDIR /var/www/html/my-vite-app
RUN npm install

# Exposez le port 9000 pour PHP-FPM
EXPOSE 9000

# Commande par défaut pour démarrer PHP-FPM
CMD ["php-fpm"]
