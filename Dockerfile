FROM php:8.2-apache

WORKDIR /var/www/html

# Habilita módulos úteis do Apache para aplicações PHP.
RUN a2enmod rewrite headers

# Copia o projeto para dentro da imagem.
COPY . /var/www/html

# Ajusta permissões básicas para o usuário do Apache.
RUN chown -R www-data:www-data /var/www/html
