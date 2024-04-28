FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install nginx

RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Angouleme/O=42/OU=42/CN=slepetit.42.fr/UID=slepetit"

COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod +x /var/www/html
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
