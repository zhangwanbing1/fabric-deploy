#!/bin/bash

sudo cp ./docker-service/* /lib/systemd/system/

cd /etc/systemd/system/multi-user.target.wants/
sudo ln -s /lib/systemd/system/docker.service docker.service
sudo ln -s /lib/systemd/system/containerd.service containerd.service

cd /etc/systemd/system/sockets.target.wants/
sudo ln -s /lib/systemd/system/docker.socket docker.socket

sudo killall dockerd
sleep 2
sudo systemctl daemon-reload
sudo systemctl start docker
sleep 2
sudo systemctl enable docker
sudo systemctl status docker