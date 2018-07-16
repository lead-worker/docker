FROM leadworker/laravel:latest

MAINTAINER Yevhen Saienko

## Install nodejs
RUN apt install -y curl software-properties-common gnupg \
    && curl -sL https://deb.nodesource.com/setup_8.x | /bin/bash - \
    && apt-get install -y nodejs

## Node tools
RUN npm i -g gulp bower