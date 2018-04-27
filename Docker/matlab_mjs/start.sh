#!/bin/bash
echo "nameserver dns.node.service.consul" > /etc/resolv.conf
echo '{"service": {"name": "node", "tags": ["mjs"]}}' | sudo tee /consul/config/node.json 
consul agent -bind 0.0.0.0 -join dns.node.service.consul -data-dir /consul/data/ -config-dir /consul/config/ -enable-script-checks=true  &
/home/mjs/toolbox/distcomp/bin/startjobmanager --name xxx -remotehost mjs.node.service.consul -v &
/home/mjs/toolbox/distcomp/bin/startworker -jobmanagerhost mjs.node.service.consul -jobmanager xxx -remotehost node1.node.service.consul &

/home/mjs/toolbox/distcomp/bin/startworker -jobmanagerhost mjs.node.service.consul -jobmanager xxx -remotehost node2.node.service.consul &
