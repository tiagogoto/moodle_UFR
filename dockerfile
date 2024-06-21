FROM php:8.2-apache 
# COPY . /var/www/html/
WORKDIR /var/www/html/


RUN apt-get update \
      && apt-get install -y apt-transport-https \
      && apt-get install -y libbz2-dev libpq-dev libssl-dev libzip-dev libcurl4-gnutls-dev libxml2 libicu-dev libpng-dev libxml2-dev zlib1g-dev librust-libsodium-sys-dev\
      && docker-php-ext-install gd zip sodium opcache soap intl exif \
      && docker-php-ext-install pdo pdo_mysql mysqli \
      && docker-php-ext-enable mysqli opcache
      
      
RUN echo "ServerName localhost:80" >> /etc/apache2/apache2.conf
RUN echo "max_input_vars=5000" >> /usr/local/etc/php
RUN a2enmod rewrite
RUN a2enmod ssl
#RUN a2enmod headers
RUN git clone git://git.moodle.org/moodle.git   
RUN chmod -R 765 /var/www/html/
RUN service apache2 restart


