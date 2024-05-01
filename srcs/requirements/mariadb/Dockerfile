FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install mariadb-server

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./script.sh /script.sh
RUN chmod 755 /script.sh

EXPOSE 3306

ENTRYPOINT [ "bash", "/script.sh" ]

CMD [ "mysqld_safe" ]