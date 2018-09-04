FROM leadworker/laravel:front_latest

MAINTAINER Yevhen Saienko

## Install angular cli
RUN npm install -g @angular/cli