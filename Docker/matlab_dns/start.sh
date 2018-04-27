#!/bin/bash
       
#port1 8300
#port2 8301
#port3 8302
#port4 8500  
#port5 8600
#port6 53

dnsmasq -D &
consul agent -server -bind 0.0.0.0 -data-dir /consul/ata/ -config-dir /consul/config/ -enable-script-checks=true
