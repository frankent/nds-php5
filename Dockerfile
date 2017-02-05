FROM alpine:3.5
RUN apk update --no-cache
RUN apk add --no-cache php5-fpm \
        php5-json \
        php5-mcrypt \
        php5-mysql \
        php5-mysqli \
        php5-xml \
        php5-curl \
        php5-iconv \
        php5-gettext \
        php5-ctype \
        php5-openssl \
        php5-pdo \
        php5-pdo_mysql \
        php5-dom \
        php5-gd \
        php5-bz2

EXPOSE 9000

COPY conf/php5-fpm.conf /etc/php5/php-fpm.conf
COPY conf/php5.ini /etc/php5/php.ini
COPY conf/php5-cron /etc/crontabs/root

CMD ["php-fpm5", "-F"]