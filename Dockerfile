FROM php:7.1.9-apache

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

RUN apt-get update && apt-get install -y supervisor git-core cron \
  libjpeg-dev libmcrypt-dev libpng-dev libpq-dev \
  && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd mcrypt mysqli opcache pdo pdo_mysql zip 

# Recommended opcache settings - https://secure.php.net/manual/en/opcache.installation.php
RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=2'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
  } > /usr/local/etc/php/conf.d/docker-ci-opcache.ini

RUN { \
    echo 'log_errors=on'; \
    echo 'display_errors=off'; \
    echo 'upload_max_filesize=32M'; \
    echo 'post_max_size=32M'; \
    echo 'memory_limit=128M'; \
    echo 'date.timezone="UTC"'; \
  } > /usr/local/etc/php/conf.d/docker-ci-php.ini

RUN { \
    echo '<FilesMatch "^\.">'; \
    echo '    Order allow,deny'; \
    echo '    Deny from all'; \
    echo '</FilesMatch>'; \
    echo '<DirectoryMatch "^\.|\/\.">'; \
    echo '    Order allow,deny'; \
    echo '    Deny from all'; \
    echo '</DirectoryMatch>'; \
  } > /etc/apache2/conf-available/docker-ci-php.conf

RUN a2enconf docker-ci-php

RUN a2enmod rewrite                

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY --chown=www-data:www-data ./app  /var/www/html

#COPY docker-entrypoint /usr/local/bin/

RUN composer install

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD /usr/bin/supervisord