#!/bin/bash
dnsmasq -D &
consul agent -server -bind 0.0.0.0 -data-dir /consul/ata/ -config-dir /consul/config/ -enable-script-checks=true
