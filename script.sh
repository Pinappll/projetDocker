#!/bin/bash
set -e

# Mettre à jour Composer à la version souhaitée
composer self-update --2

# Installer les dépendances Laravel
composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev

# Générer la clé d'application Laravel
php artisan key:generate

# Exécuter les migrations avec seed
if [ "$RUN_MIGRATIONS" = "true" ]; then
  php artisan migrate --seed
fi

# Installer les dépendances Node.js et construire les assets
npm install
npm run build

# Lancer php-fpm
exec php-fpm