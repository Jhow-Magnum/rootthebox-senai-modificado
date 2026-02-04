#!/bin/bash

# Nome da imagem do container
IMAGEM_DO_CONTAINER="nycolases6/ubuntu-bind9-nginx-ssh:1.1"

# Se desejar instalar o RootTheBox junto ao jogo
ROOTTHEBOX="True"

# Defina as portas que o container ira usar
PORTAS_DO_CONTAINER="80,22,2022"

sudo echo "Port 2022" >> /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo apt update
sudo mkdir -p /data

sudo apt install docker docker-compose python3-psutil python3-pip python3-yaml python3-jinja2 python3-apt git -y
sudo python3 -m pip install rich

sudo git clone https://github.com/kfellipe/rootthebox-senai.git /data/rootthebox-senai

sudo cat <<EOF>/etc/systemd/system/start-ctf.service
[Unit]
Description=Serviço para iniciar container do CTF
After=network-online.target docker.service
Wants=network-online.target
Requires=docker.service

[Service]
Type=oneshot
ExecStart=/bin/bash /data/rootthebox-senai/start-container-AWS.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

sudo python3 /data/rootthebox-senai/main.py "True" $ROOTTHEBOX $IMAGEM_DO_CONTAINER $PORTAS_DO_CONTAINER

sudo systemctl daemon-reload
sudo systemctl enable start-ctf
sudo systemctl start start-ctf