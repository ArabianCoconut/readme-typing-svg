FROM php:7.4-apache
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions @composer
# Copy existing application directory contents
COPY . /var/www

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN composer install

# Change current user to www
USER www-data

WORKDIR /var/www/src
EXPOSE 8080

# Stats the development server
CMD [ "php", "-S", "0.0.0.0:8080"]