FROM yujmo/ubuntu:16.04

ENV ROLE matlab_R2018a_license_manager

MAINTAINER yujmo yujmo94@gmail.com
                                                                                 
ADD matlab /home/matlab
                                                                               
RUN sed -i "s/admin/license.node.service.consul/g" /home/matlab/etc/license.dat  \
  && apt-get install wget dnsmasq unzip -y \
  && wget https://releases.hashicorp.com/consul/1.0.7/consul_1.0.7_linux_amd64.zip \
  && unzip consul_1.0.7_linux_amd64.zip \
  && cp consul /usr/sbin/ \
  && rm -rf /consul* && mkdir -p /consul/config \
  && mkdir -p /consul/data 
