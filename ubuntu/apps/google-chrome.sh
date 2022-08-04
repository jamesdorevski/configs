#! /usr/bin/bash

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/Downloads/google-chrome.deb

sudo apt install -y ~/Downloads/google-chrome.deb

rm ~/Downloads/google-chrome.deb
