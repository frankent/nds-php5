FROM php:5-fpm
RUN apt-get update
RUN apt-get install -y  --no-install-recommends \
                        autoconf \
                        apt-utils \
                        automake \
                        libtool \
                        m4 \
                        openssl \
                        libmcrypt-dev \
                        libxml2-dev \
                        libcurl4-openssl-dev \
                        libvpx-dev \
                        libjpeg-dev \
                        libpng-dev \
                        libbz2-dev \
                        libfreetype6-dev \
                        libjpeg62-turbo-dev \
                        libmagickwand-dev \
                        wget \
                        libthai0 \
                        xfonts-thai \
                        gdebi-core \
                        libcurl4-openssl-dev \
                        libssl-dev \
                        pkg-config

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN pecl channel-update pecl.php.net
RUN pecl install mongodb
RUN pecl install imagick
RUN pecl install redis-2.2.8

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
        exif \
        calendar \
        zip

RUN docker-php-ext-enable mongodb \
	&& docker-php-ext-enable redis \
	&& docker-php-ext-enable imagick \
	&& docker-php-source delete

RUN docker-php-source delete

# COPY conf/php5-fpm.conf /usr/local/etc/php-fpm.d/www.conf
# COPY conf/php5.ini /usr/local/etc/php/
# COPY conf/php5.ini /usr/local/etc/php/conf.d/php.ini

RUN cd /tmp
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.2.1/wkhtmltox-0.12.2.1_linux-jessie-amd64.deb
RUN gdebi --non-interactive wkhtmltox-0.12.2.1_linux-jessie-amd64.deb
RUN rm -rf /tmp/*

EXPOSE 9000
WORKDIR /var/www/html

# CMD ["php-fpm", "-F"]