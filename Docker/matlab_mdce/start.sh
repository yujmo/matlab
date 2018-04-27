#!/bin/bash
#port1: 32000               -               
#port2: 4455
#port3: 27352
#port4: 27353

#node_name=`echo $MY_POD_NAME |cut -d . -f 1`


echo "101.132.149.154 student" >> /etc/hosts 
echo "nameserver dns.default.svc.cluster.local" > /etc/resolv.conf
echo '{"service": {"name": "node", "tags": ["$MY_POD_NAME"]}}' | sudo tee /consul/config/node.json 
/home/mdce/toolbox/distcomp/bin/mdce start &
consul agent -bind 0.0.0.0 -join dns.default.svc.cluster.local -data-dir /consul/data/ -config-dir /consul/config/ -enable-script-checks=true
