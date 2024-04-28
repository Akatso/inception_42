FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
