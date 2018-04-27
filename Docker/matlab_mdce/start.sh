#!/bin/bash
#port1: 32000               -               
#port2: 4455
#port3: 27352
#port4: 27353

echo "nameserver dns.node.service.consul" > /etc/resolv.conf
echo '{"service": {"name": "node", "tags": ["node1"]}}' | sudo tee /consul/config/node.json 
consul agent -bind 0.0.0.0 -join dns.node.service.consul -data-dir /consul/data/ -config-dir /consul/config/ -enable-script-checks=true  &
/home/mdce/toolbox/distcomp/bin/mdce start &
