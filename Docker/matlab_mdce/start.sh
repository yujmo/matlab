#!/bin/bash
#port1: 32000               -               
#port2: 4455
#port3: 27352
#port4: 27353
apt-get install iputils-ping net-tools openssh-client openssh-server -y
sed -i "s/admin/student/g" /home/mdce/licenses/network.lic 
echo {\"service\": {\"name\": \"node\", \"tags\": [\"$MY_POD_NAME\"]}} | tee /consul/config/node.json 
#echo "101.132.149.154 student" >> /etc/hosts 

consul agent -bind 0.0.0.0 -join dns -data-dir /consul/data/ -config-dir /consul/config/ -enable-script-checks=true &

STRING=`netstat -ntulp|grep consul`

while [ -z "$STRING" ];do
    sleep 1
    STRING=`netstat -ntulp|grep consul`
done

dns_ip=`consul members |grep server | awk '{print $2}' | cut -d : -f 1`
echo "nameserver $dns_ip" > /etc/resolv.conf
/home/mdce/toolbox/distcomp/bin/mdce start 

cp /etc/hosts /etc/hosts.bak 

/usr/sbin/sshd -D &
STRING_SSHD=`netstat -ntulp|grep 22`
while [ -z "$STRING_SSHD" ];do
    sleep 1
    STRING_SSHD=`netstat -ntulp|grep 22`
done

while true
do
    consul members |grep client | awk -F : '{print $1}' | awk '{print $2 , $1}' > /etc/hosts
    cat /etc/hosts.bak >> /etc/hosts
    sleep 1
done
