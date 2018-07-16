FROM php:7.1-apache

MAINTAINER Yevhen Saienko

COPY . /srv/app
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# Set permissions
RUN chown -R www-data:www-data /srv/app \
    && a2enmod rewrite

## Install PHP extentions
RUN apt-get update \
    && apt-get install -y zlib1g-dev \
    && docker-php-ext-install zip mbstring pdo pdo_mysql

## Install tools
RUN apt-get -y install less nano

## Install nodejs
RUN apt install -y curl software-properties-common gnupg \
    && curl -sL https://deb.nodesource.com/setup_8.x | /bin/bash - \
    && apt-get install -y nodejs

## Node tools
RUN npm i -g gulp bower