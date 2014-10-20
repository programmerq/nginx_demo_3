FROM ubuntu:14.04
RUN apt-get -y update
RUN apt-get -y install nginx git curl
RUN git clone https://github.com/sstephenson/bats.git && cd bats && ./install.sh /usr/local
RUN mkdir /www && chown www-data:www-data /www
ADD htpasswd /
ADD default.conf /etc/nginx/sites-available/default
ADD nginx.bats /
