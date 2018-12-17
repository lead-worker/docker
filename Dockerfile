FROM php:7.1-apache

MAINTAINER Yevhen Saienko

COPY . /srv/app
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf

## Install PHP extentions
RUN apt-get update
RUN apt-get install -y zlib1g-dev
RUN docker-php-ext-install zip mbstring pdo pdo_mysql

## Install supervisor (for queues workers)
RUN apt-get install -y supervisor
RUN service supervisor start

## Install cron
RUN apt-get install -y cron
RUN service cron start

## Install GD
RUN apt-get install -y libpng-dev
RUN docker-php-ext-install gd

## Install Imagick
RUN apt-get install -y libmagickwand-dev
RUN pecl install imagick
RUN docker-php-ext-enable imagick

## Install tools
RUN apt-get -y install less nano git zip

# Set permissions
RUN chown -R www-data:www-data /srv/app \
    && a2enmod rewrite
