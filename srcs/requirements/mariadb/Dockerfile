FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get -y update && apt-get -y upgrade
RUN apt -y install mariadb-server galera-4 mariadb-client libmariadb3 mariadb-backup mariadb-common

COPY conf/mariadb.conf	/etc/mysql/mariadb.conf.d/mariadb.conf

# COPY conf/script.sh /etc/mysql/mariadb.conf.d/script.sh
# RUN  chmod 755 /etc/mysql/mariadb.conf.d/script.sh
COPY --chmod=755 script.sh /

EXPOSE 3306

ENTRYPOINT [ "bash", "script.sh" ]

# CMD [ "mysqld_safe" ]
