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
RUN apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libxpm-dev \
    libvpx-dev \
&& docker-php-ext-configure gd \
    --with-freetype-dir=/usr/lib/x86_64-linux-gnu/ \
    --with-jpeg-dir=/usr/lib/x86_64-linux-gnu/ \
    --with-xpm-dir=/usr/lib/x86_64-linux-gnu/ \
    --with-vpx-dir=/usr/lib/x86_64-linux-gnu/ \
&& docker-php-ext-install gd

## Install Imagick
RUN apt-get install -y libmagickwand-dev
RUN pecl install imagick
RUN docker-php-ext-enable imagick

## Install tools
RUN apt-get -y install less nano git zip

# Set permissions
RUN chown -R www-data:www-data /srv/app \
    && a2enmod rewrite
