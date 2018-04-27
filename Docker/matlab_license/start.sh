#!/bin/bash
#port1:27000                   -               
#port2:32847 
echo "nameserver dns.node.service.consul" > /etc/resolv.conf
echo '{"service": {"name": "node", "tags": ["license"]}}' | sudo tee /consul/config/node.json 
consul agent -bind 0.0.0.0 -join dns.node.service.consul -data-dir /consul/data/ -config-dir /consul/config/ -enable-script-checks=true  &
sudo -u admin /home/matlab/etc/lmstart 
