FROM debian:bullseye

RUN apt-get -y update && apt-get -y install nginx

RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Angouleme/O=42/OU=42/CN=slepetit.42.fr/UID=slepetit"
COPY conf/nginx.conf /etc/nginx/nginx.conf
