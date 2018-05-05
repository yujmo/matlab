#!/bin/bash
##############################

apt-mark hold initscripts udev plymouth mountall

dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

apt-get update && apt-get install -y --force-yes --no-install-recommends supervisor \
        openssh-server openssh-client pwgen sudo vim-tiny net-tools lxde x11vnc xvfb gtk2-engines-murrine ttf-ubuntu-font-family nodejs 
apt-get autoclean 
apt-get autoremove && rm -rf /var/lib/apt/lists/*

wget https://github.com/yujmo/dockerized-openoffice/archive/v1.1.tar.gz
tar -xvf v1.1.tar.gz
cp dockerized-openoffice-1.1/noVNC/ / -r
cp dockerized-openoffice-1.1/startup.sh / -r                                                                                                
cp dockerized-openoffice-1.1/supervisord.conf / -r  
bash /startup.sh 
#############################




sed -i "s/admin/student/g" /home/mjs/licenses/network.lic 

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
/home/mjs/toolbox/distcomp/bin/startworker -jobmanagerhost mjs -jobmanager xxx -remotehost node1 -v
/home/mjs/toolbox/distcomp/bin/startworker -jobmanagerhost mjs -jobmanager xxx -remotehost node2 -v

mkdir -p /var/run/sshd

/usr/sbin/sshd -D &

while true
do
    consul members |grep client | awk -F : '{print $1}' | awk '{print $2 , $1}' > /etc/hosts
    cat /etc/hosts.bak >> /etc/hosts
    sleep 1
done
