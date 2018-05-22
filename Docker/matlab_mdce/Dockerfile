FROM nvidia/cuda:9.2-devel-ubuntu16.04

ADD mdce /home/mdce

RUN apt-get update && apt-get install unzip wget -y \
  && wget https://releases.hashicorp.com/consul/1.0.7/consul_1.0.7_linux_amd64.zip \
  && unzip consul_1.0.7_linux_amd64.zip \
  && cp consul /usr/sbin/ \
  && rm -rf /consul* \ 
  && mkdir -p /consul/config && mkdir -p /consul/data && mkdir -p /var/run/sshd
