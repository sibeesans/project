#!/bin/bash
# Edition : Stable Edition V3.0
# Auther  : Geo Project
# (C) Copyright 2023
# =========================================

# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8' >/dev/null 2>&1
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
grenbo="\e[92;1m"
NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"
clear
date
echo ""
echo -e "${GREEN}Untuk Melakukan Tindakan Ini, Anda Harus Laporan Terlebih Dahulu Kepada Pihak Admin.$NC"
echo -e "${GREEN}Agar Diberikan Akses Pembaruan Pada Script VPS Anda!$NC"
read -p "Sudah Laporan? [Y/N]:" arg
if [[ $arg == 'Y' ]]; then
  echo -e "${CYAN}Tindakan Diteruskan! $NC"
  echo -e "${GREEN}START. . . $NC"
elif [[ $arg == 'y' ]]; then
  echo -e "${CYAN}Tindakan Diteruskan! $NC"
  clear
  echo -e "${CYAN}START . . .$NC"
elif [[ $arg == 'N' ]]; then
  echo -e "${RED}Tindakan Dihentikan! $NC"
  sleep 1
  clear
  neofetch
  exit 0
elif [[ $arg == 'n' ]]; then
  echo -e "${RED}Tindakan Dihentikan! $NC"
  sleep 1
  clear
  rm -f /root/update.sh
  exit 0
else
  echo -e "${RED}Argumen Tidak Diketahui! $NC"
  sleep 1
  clear
  rm -f /root/update.sh
  exit 0
fi
##########

clear
mkdir -p /usr/local/geovpn/
mkdir -p /etc/geovpn/
mkdir -p /etc/systemd/system/
# // Installing ePro WebSocket Proxy
echo -e "[ ${GREEN}INFO${NC} ] Installing ePro WebSocket Proxy"
wget -q -O /usr/local/geovpn/ws-epro "https://jaka1m.github.io/project/mantap/ws-epro"
chmod +x /usr/local/geovpn/ws-epro
wget -q -O /etc/geovpn/ws-epro.conf "https://jaka1m.github.io/project/mantap/ws-epro.conf"
chmod 644 /etc/geovpn/ws-epro.conf
wget -q -O /etc/systemd/system/ws-epro.service "https://jaka1m.github.io/project/mantap/ws-epro.service"
systemctl disable ws-epro
systemctl stop ws-epro
systemctl enable ws-epro
systemctl start ws-epro
systemctl restart ws-epro

clear
wget -O ~/menu.zip "https://jaka1m.github.io/project/mantap/menu/menu.zip" >/dev/null 2>&1
mkdir /root/menu
7z e  ~/menu.zip -o/root/menu/ >/dev/null 2>&1
chmod +x /root/menu/*
mv /root/menu/* /usr/local/sbin/
    
sleep 2
clear
# banner /etc/issue.net
# download script
echo -e "[ ${GREEN}INFO${NC} ] Download File Script "
sleep 2
clear
menu
