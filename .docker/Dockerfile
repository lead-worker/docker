FROM php:7.1-apache

MAINTAINER Yevhen Saienko

COPY . /srv/app
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# Set permissions
RUN chown -R www-data:www-data /srv/app \
    && a2enmod rewrite \
    && cd /srv/app \
    && chmod -R o+rw bootstrap/ storage/

## Install PHP extentions
RUN apt-get update \
    && apt-get install -y zlib1g-dev \
    && docker-php-ext-install zip mbstring pdo pdo_mysql

## Install tools
RUN apt-get -y install less nano