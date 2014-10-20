FROM ubuntu:14.04
RUN apt-get -y update
RUN apt-get -y install nginx git
RUN git clone https://github.com/sstephenson/bats.git && cd bats && ./install.sh /usr/local
ADD nginx.bats /
