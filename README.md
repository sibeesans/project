### GASS PAKAI

```
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt upgrade -y && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://raw.githubusercontent.com/sibeesans/project/main/primo.sh && chmod +x primo.sh && sed -i -e 's/\r$//' primo.sh && screen -S primo ./primo.sh
```
