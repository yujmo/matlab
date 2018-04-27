FROM yujmo/ubuntu:16.04

RUN apt-get install wget dnsmasq unzip -y \
  && wget https://releases.hashicorp.com/consul/1.0.7/consul_1.0.7_linux_amd64.zip \
  && unzip consul_1.0.7_linux_amd64.zip \
  && cp consul /usr/sbin/ \
  && echo "user=root" > /etc/dnsmasq.conf \
  && echo "server=/consul/127.0.0.1#8600" >> /etc/dnsmasq.conf \
  && rm -rf /consul* \ 
  && mkdir -p /consul/config && mkdir -p /consul/data

