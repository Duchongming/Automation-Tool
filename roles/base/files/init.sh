#!/bin/bash

#Install packages
yum install -y bash-completion.noarch bash-completion-extras.noarch wget vim asciidoc xmlto docbook2x curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-ExtUtils-MakeMaker gd-devel java-1.8.0-openjdk  java-1.8.0-openjdk-devel
yum groups install -y "System Administration Tools" "Development Tools" "System Management"

#set sysctl
cat << EOF > /etc/sysctl.conf
net.ipv4.ip_forward = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
net.ipv4.tcp_max_tw_buckets = 8192
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rmem = 4096 87380 4194304
net.ipv4.tcp_wmem = 4096 16384 4194304
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.netdev_max_backlog = 262144
net.core.somaxconn = 262144
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_max_syn_backlog = 262144
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_fin_timeout = 20
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_keepalive_intvl = 10
net.ipv4.ip_local_port_range = 1024 65000
fs.file-max = 65535
net.ipv4.tcp_retries2 = 3
net.ipv4.route.gc_timeout = 100
EOF
sysctl -p &>/dev/null

#Install docker-ce
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum install  docker-ce-17.12.1.ce-1.el7.centos -y
systemctl start docker&&systemctl enable docker