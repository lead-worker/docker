FROM php:7.1-apache

MAINTAINER Yevhen Saienko

COPY . /srv/app

## Install PHP extentions
RUN apt-get update
RUN apt-get install -y zlib1g-dev
RUN docker-php-ext-install zip mbstring pdo pdo_mysql

## Install supervisor (for queues workers)
RUN apt-get install -y supervisor

## Install cron
RUN apt-get install -y cron

# To remove !!!! -> move to bash scripts
### Install GD
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


# To remove !!!! -> move to bash scripts
### Install Imagick
RUN apt-get install -y libmagickwand-dev
RUN pecl install imagick
RUN docker-php-ext-enable imagick

## Install tools
RUN apt-get -y install less nano git zip vim

# Set permissions
#RUN chown -R www-data:www-data /srv/app

# Apache2 modules activation
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod headers

## Install cerbot
RUN apt-get install -y certbot python-certbot-apache

### Move to conditinally applying !!!! => with docker-compose files

#####################
# Front
#####################

## Update repositories
RUN apt-get update

## Install nodejs
RUN apt install -y curl software-properties-common gnupg \
    && curl -sL https://deb.nodesource.com/setup_8.x | /bin/bash - \
    && apt-get install -y nodejs

## Node tools
RUN npm i -g gulp

## Install SASS
RUN apt-get install -y sass

### Move to conditinally applying !!!! => with docker-compose files
