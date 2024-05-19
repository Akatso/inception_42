FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install wget

RUN apt-get install -y php7.3
RUN apt-get install -y php-fpm
RUN apt-get install -y php-mysql
RUN apt-get install -y mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.5.2-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.5.2-fr_FR.tar.gz
RUN rm -rf wordpress-6.5.2-fr_FR.tar.gz
RUN	chown -R root:root /var/www/wordpress

COPY ./conf/wordpress.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY /conf/script.sh /script.sh
RUN chmod 755 /script.sh

EXPOSE 9000

ENTRYPOINT [ "bash", "/script.sh" ]