#! /usr/bin/bash

wget https://get.docker.com/ -O ~/Downloads/docker-installer.sh

bash ~/Downloads/docker-installer.sh

sudo usermod -aG docker $USER
newgrp docker 

rm ~/Downloads/docker-installer.sh
