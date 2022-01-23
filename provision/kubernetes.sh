#!/bin/env bash

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

sudo setenforce 0

sudo sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/selinux/config

swapoff -a

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

# sudo kubeadm reset -y

sudo kubeadm init --pod-network-cidr=10.1.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# sudo kubeadm init --pod-network-cidr=10.1.0.0/16

kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml

kubectl create -f /vagrant/calico/custom-resources.yaml

# watch kubectl get pods -n calico-system

kubectl taint nodes --all node-role.kubernetes.io/master-

# kubectl get nodes -o wide

sudo systemctl enable --now kubelet

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml