#!/bin/bash
#port1:27000                   -               
#port2:32847 
apt-get install iputils-ping net-tools -y
echo {\"service\": {\"name\": \"node\", \"tags\": [\"$MY_POD_NAME\"]}} | tee /consul/config/node.json 
sed -i "s/license.node.service.consul/student/g" /home/matlab/etc/license.dat 

consul agent -bind 0.0.0.0 -join dns -data-dir /consul/data/ -config-dir /consul/config/ -enable-script-checks=true &

STRING=`netstat -ntulp|grep consul`

while [ -z "$STRING" ];do
    sleep 1
    STRING=`netstat -ntulp|grep consul`
done

dns_ip=`consul members |grep server | awk '{print $2}' | cut -d : -f 1`
echo "nameserver $dns_ip" > /etc/resolv.conf

sudo -u admin /home/matlab/etc/lmstart 

cp /etc/hosts /etc/hosts.bak 
while true
do
    consul members |grep client | awk -F : '{print $1}' | awk '{print $2 , $1}' > /etc/hosts
    cat /etc/hosts.bak >> /etc/hosts
    sleep 1
done
