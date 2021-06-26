FROM composer:2 as composer

FROM php:8.0-apache

RUN apt-get install -y $PHPIZE_DEPS \
        && rm -rf /var/lib/apt/lists/* \
        && pecl install redis \
        && docker-php-ext-enable redis \
        && docker-php-ext-install bcmath \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install pcntl \
        && docker-php-ext-install opcache \
        && docker-php-ext-install sysvmsg \
        && docker-php-ext-install sysvsem \
        && docker-php-ext-install sysvshm

COPY --from=composer /usr/bin/composer /usr/bin/composer
