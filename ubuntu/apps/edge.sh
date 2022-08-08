#!/usr/bin/bash

wget https://go.microsoft.com/fwlink?linkid=2149051 -O ~/Downloads/edge.deb
sudo apt install -y ~/Downloads/edge.deb
rm ~/Downloads/edge.deb
