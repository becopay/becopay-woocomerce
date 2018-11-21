FROM becopay/alpine-nginx-php

LABEL maintainer="io@becopay.com"
LABEL version="4.9.8"
LABEL description="Wordpress with woocommerce and becopay plugin"

ENV WORDPRESS_VERSION 4.9.8
ENV WOOCOMMERCE_VERSION 3.5.1
ENV BECOPAY_VERSION master

ENV WOOCOMMERCE_PLUGIN woocommerce
ENV BECOPAY_PLUGIN Woocommerce-Becopay-Gateway

ENV INSTALL_DIR /var/www/html
ENV WOOCOMMERCE_DIR $INSTALL_DIR/wp-content/plugins/$WOOCOMMERCE_PLUGIN
ENV BECOPAY_DIR $INSTALL_DIR/wp-content/plugins/$BECOPAY_PLUGIN

ADD ./php.ini /etc/php7/php.ini

ADD ./nginx.conf /etc/nginx/conf.d/default.conf

RUN cd /tmp && \
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
  php wp-cli.phar --info && \
  chmod +x wp-cli.phar && \
  mv wp-cli.phar /usr/local/bin/wp

RUN chsh -s /bin/bash www-data

RUN cd /tmp && \ 
  curl https://codeload.github.com/WordPress/WordPress/tar.gz/$WORDPRESS_VERSION -o $WORDPRESS_VERSION.tar.gz && \
  tar xvf $WORDPRESS_VERSION.tar.gz && \
  mv WordPress-$WORDPRESS_VERSION/* $INSTALL_DIR

RUN mkdir $WOOCOMMERCE_DIR

RUN cd /tmp && \
  curl https://codeload.github.com/woocommerce/woocommerce/tar.gz/$WOOCOMMERCE_VERSION -o $WOOCOMMERCE_VERSION.tar.gz && \
  tar xvf $WOOCOMMERCE_VERSION.tar.gz && \
  mv -f woocommerce-$WOOCOMMERCE_VERSION/* $WOOCOMMERCE_DIR

RUN mkdir $BECOPAY_DIR

RUN cd /tmp && \
  curl https://codeload.github.com/becopay/Woocommerce-Becopay-Gateway/tar.gz/$BECOPAY_VERSION -o $BECOPAY_VERSION.tar.gz && \
  tar xvf $BECOPAY_VERSION.tar.gz && \
  mv -f Woocommerce-Becopay-Gateway-$BECOPAY_VERSION/* $BECOPAY_DIR

RUN chown -R www-data:www-data /var/www

COPY ./install-wordpress /usr/local/bin/install-wordpress
RUN chmod +x /usr/local/bin/install-wordpress

RUN cd $INSTALL_DIR \
    && find . -type d -exec chmod 770 {} \; \
    && find . -type f -exec chmod 660 {} \;

RUN rm -rf /tmp/*

WORKDIR $INSTALL_DIR
