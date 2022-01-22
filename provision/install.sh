#!/bin/env bash

yum update -y

yum install -y git nginx

sudo systemctl start nginx