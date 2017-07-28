FROM php:5-fpm
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y  autoconf \
                        automake \
                        libtool \
                        m4 \
                        libmcrypt-dev \
                        libxml2-dev \
                        libcurl4-openssl-dev \
                        libvpx-dev \
                        libjpeg-dev \
                        libpng-dev \
                        libbz2-dev \
                        libfreetype6-dev \
                        libjpeg62-turbo-dev \
                        libpng12-dev

# RUN cp /usr/src/php/ext/zlib/config0.m4 /usr/src/php/ext/zlib/config.m4

RUN docker-php-source extract
RUN docker-php-ext-install json \
        mcrypt \
        mysql \
        mysqli \
        pdo \
        pdo_mysql \
        xml \
        curl \
        iconv \
        gettext \
        ctype \
        dom \
        gd \
        bz2 \
        zip

        #openssl

RUN docker-php-source delete
# COPY conf/php5-fpm.conf /usr/local/etc/php-fpm.d/www.conf
COPY conf/php5.ini /usr/local/etc/php/
COPY conf/php5.ini /usr/local/etc/php/conf.d/php.ini

EXPOSE 9000
WORKDIR /var/www/html


CMD ["php-fpm", "-F"]