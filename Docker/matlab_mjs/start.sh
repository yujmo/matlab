#!/bin/bash


echo '{"service": {"name": "node", "tags": ["mjs"]}}' | tee /consul/config/node.json 

consul agent -bind 0.0.0.0 -join dns -data-dir /consul/data/ -config-dir /consul/config/ -enable-script-checks=true  &
STRING=`netstat -ntulp|grep consul`

while [ -z "$STRING" ];do
    sleep 1
    STRING=`netstat -ntulp|grep consul`
done

#echo "101.132.149.154 student" >> /etc/hosts
dns_ip=`consul members |grep server | awk '{print $2}' | cut -d : -f 1`

echo "nameserver $dns_ip" > /etc/resolv.conf


cp /etc/hosts /etc/hosts.bak 

consul members |grep client | awk -F : '{print $1}' | awk '{print $2 , $1}' > /etc/hosts
cat /etc/hosts.bak >> /etc/hosts

/home/mjs/toolbox/distcomp/bin/mdce start 
/home/mjs/toolbox/distcomp/bin/startjobmanager -name xxx -remotehost mjs -v 
/home/mjs/toolbox/distcomp/bin/startworker -jobmanagerhost mjs -jobmanager xxx -remotehost node1
/home/mjs/toolbox/distcomp/bin/startworker -jobmanagerhost mjs -jobmanager xxx -remotehost node2



while true
do
    consul members |grep client | awk -F : '{print $1}' | awk '{print $2 , $1}' > /etc/hosts
    cat /etc/hosts.bak >> /etc/hosts
    sleep 1
done
