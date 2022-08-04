#! /usr/bin/bash

wget https://az764295.vo.msecnd.net/stable/da76f93349a72022ca4670c1b84860304616aaa2/code_1.70.0-1659589288_amd64.deb -O ~/Downloads/code.deb

sudo apt install -y ~/Downloads/code.deb

rm ~/Downloads/code.deb
