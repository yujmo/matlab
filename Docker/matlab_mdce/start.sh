#!/bin/bash
#port1: 32000               -               
#port2: 4455
#port3: 27352
#port4: 27353
apt-get install iputils-ping -y
echo '{"service": {"name": "node", "tags": ["$MY_POD_NAME"]}}' | tee /consul/config/node.json 

echo "101.132.149.154 student" >> /etc/hosts 
consul agent -bind 0.0.0.0 -join dns.default.svc.cluster.local -data-dir /consul/data/ -config-dir /consul/config/ -enable-script-checks=true &

dns_ip=`consul members |grep server | awk '{print $2}' | cut -d : -f 1`

echo "nameserver $dns_ip" > /etc/resolv.conf

/home/mdce/toolbox/distcomp/bin/mdce start 

ping 127.0.0.1 > /dev/null
