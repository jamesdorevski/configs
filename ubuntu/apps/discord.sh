#! /usr/bin/bash

wget https://dl.discordapp.net/apps/linux/0.0.18/discord-0.0.18.deb -O ~/Downloads/discord.deb

sudo apt install -y ~/Downloads/discord.deb

rm ~/Downloads/discord.deb
