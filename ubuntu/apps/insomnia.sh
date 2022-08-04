#! /usr/bin/bash

wget https://objects.githubusercontent.com/github-production-release-asset-2e65be/56899284/eb3e710f-e3b4-4c80-8cf9-f1495be0f3b3?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220804%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220804T215647Z&X-Amz-Expires=300&X-Amz-Signature=5b32b79af46752a0617537f6e669cef67d98821537122f192c5d803441f4ca36&X-Amz-SignedHeaders=host&actor_id=46879069&key_id=0&repo_id=56899284&response-content-disposition=attachment%3B%20filename%3DInsomnia.Core-2022.5.0.deb&response-content-type=application%2Foctet-stream -O ~/Downloads/insomnia.deb

sudo apt install -y ~/Downloads/insomnia.deb

rm ~/Downloads/insomnia.deb
