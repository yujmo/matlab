#!/bin/bash
echo "101.132.149.154 student" >> /etc/hosts

echo '{"service": {"name": "node", "tags": ["mjs"]}}' | tee /consul/config/node.json 

consul agent -bind 0.0.0.0 -join dns.default.svc.cluster.local -data-dir /consul/data/ -config-dir /consul/config/ -enable-script-checks=true  &

/home/mjs/toolbox/distcomp/bin/startjobmanager --name xxx -remotehost mjs.node.service.consul -v 
/home/mjs/toolbox/distcomp/bin/startworker -jobmanagerhost mjs.node.service.consul -jobmanager xxx -remotehost node1.node.service.consul 
/home/mjs/toolbox/distcomp/bin/startworker -jobmanagerhost mjs.node.service.consul -jobmanager xxx -remotehost node2.node.service.consul 


dns_ip=`consul members |grep server | awk '{print $2}' | cut -d : -f 1`

echo "nameserver $dns_ip" > /etc/resolv.conf

ping 127.0.0.1 > /dev/null
