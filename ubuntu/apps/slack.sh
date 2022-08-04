#! /usr/bin/bash

wget https://downloads.slack-edge.com/releases/linux/4.27.156/prod/x64/slack-desktop-4.27.156-amd64.deb -O ~/Downloads/slack.deb

sudo apt install -y ~/Downloads/slack.deb

rm ~/Downloads/slack.deb
