# Grauss VM POC

## Introduction

Start vm POC

## Requirements

Software requirements:

- https://www.vagrantup.com/

VM requirements:

- CPU: 1
- Memory: 2GB

## Install

Add to /etc/hosts file:
```
{{ vagrant_vm-grauss-poc_ip }} vm-grauss-poc
```

Use Vagrant

```
$ vagrant up
```

### Dashboard

```
$ kubectl proxy --address='0.0.0.0' --port=8002 --accept-hosts='.*'
```