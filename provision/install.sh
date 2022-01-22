#!/bin/env bash

yum update -y

yum install -y git nginx

sudo systemctl start nginx

# sudo ifconfig eth1 192.168.1.111 netmask 255.255.255.0 up