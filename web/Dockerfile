FROM php:8.2-apache

# Installation des extensions pour connecter PHP à MariaDB/MySQL
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Activation de l'URL rewriting (souvent utile en projet PHP)
RUN a2enmod rewrite
