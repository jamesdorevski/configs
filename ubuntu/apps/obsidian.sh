#!/usr/bin/bash
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.15.9/obsidian_0.15.9_amd64.deb -O ~/Downloads/obsidian.deb
sudo apt install -y ~/Downloads/obsidian.deb
rm ~/Downloads/obsidian.deb
