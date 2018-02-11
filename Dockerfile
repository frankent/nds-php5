FROM php:5-fpm
RUN apt-get update && apt-get upgrade -y
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
                        libpng12-dev \
                        libmagickwand-dev \
                        wget \
                        libthai0 \
                        xfonts-thai \
                        gdebi-core \
                        libcurl4-openssl-dev \
                        libssl-dev \
                        pkg-config

# RUN cp /usr/src/php/ext/zlib/config0.m4 /usr/src/php/ext/zlib/config.m4
RUN pecl channel-update pecl.php.net \
        && pecl install mongodb \
	&& pecl install redis \
	&& pecl install imagick

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
COPY conf/php5.ini /usr/local/etc/php/
COPY conf/php5.ini /usr/local/etc/php/conf.d/php.ini

RUN cd /tmp \
        && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.2.1/wkhtmltox-0.12.2.1_linux-jessie-amd64.deb \
        && gdebi --non-interactive wkhtmltox-0.12.2.1_linux-jessie-amd64.deb \
        && rm -rf /tmp/*

EXPOSE 9000
WORKDIR /var/www/html


CMD ["php-fpm", "-F"]