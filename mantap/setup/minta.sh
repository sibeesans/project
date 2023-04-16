#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition 3.0
# Auther  : Geo Project
# (C) Copyright 2023
# =========================================
export GREEN='\033[0;32m'
export NC='\033[0m'
clear
echo ""
echo ""
# // Setup
echo -e "${GREEN}DOWNLOADING FILE SETUP!${NC}"
sleep 3
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl && wget https://jaka1m.github.io/project/mantap/setup/setup.sh && chmod +x setup.sh && ./setup.sh
rm -f /root/minta.sh > /dev/null 2>&1
echo ""
