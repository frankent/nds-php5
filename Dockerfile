FROM php:5.6.31-fpm-alpine
RUN docker-php-source extract
RUN docker-php-ext-install 
        fpm \
        json \
        mcrypt \
        mysql \
        mysqli \
        xml \
        curl \
        iconv \
        gettext \
        ctype \
        openssl \
        pdo \
        pdo_mysql \
        dom \
        gd \
        bz2

RUN docker-php-source delete

EXPOSE 9000
WORKDIR /var/www/html

CMD ["php5-fpm", "-F"]