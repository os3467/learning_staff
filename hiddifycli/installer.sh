#!/bin/bash

echo -e "\nInstalling tar\n"
sudo apt install tar -y

echo -e "\nDownloading HiddifyCli from Github\n"
wget https://github.com/hiddify/hiddify-core/releases/download/v3.1.8/hiddify-cli-linux-amd64.tar.gz

echo -e "\nExtracting from tar.gz\n"
tar -xvzf hiddify-cli-linux-amd64.tar.gz
rm hiddify-cli-linux-amd64.tar.gz

echo -e "\nMoving HiddifyCli to /usr/bin\n"
sudo mv HiddifyCli /usr/bin/
chmod +x /usr/bin/HiddifyCli

touch server.txt

echo -e "\nDone\n\n"

tee ./vpn.sh 1>/dev/null <<EOF
#!/bin/bash

STATE="OFF"

while true; do
if [[ \$STATE == "ON" ]]; then
    nohup sudo HiddifyCli run -c ./server.txt -d ./.config.json &>/dev/null &
    while true; do
        clear
        echo "█     █  █████   ██    █          █████   ██    █"
        echo "█     █  █    █  █ █   █         █     █  █ █   █"
        echo " █   █   █████   █  █  █         █     █  █  █  █"
        echo "  █ █    █       █   █ █         █     █  █   █ █"
        echo "   █     █       █    ██          █████   █    ██"
        echo ""
	pi=\$(ping -c 1 1.1.1.1 | grep "from")  && echo \$pi || echo "Ping Failed ..."
	echo ""
	echo "Press any key to turn off."
	read -rsn1 -t 2 KEY
	if [[ -n \$KEY ]]; then
            STATE="OFF"
	    break
        fi
    done

elif [[ \$STATE == "OFF" ]]; then
    sudo pkill HiddifyCli
    while true; do
	clear
    	echo "█     █  █████   ██    █          █████   ██████  ██████"
    	echo "█     █  █    █  █ █   █         █     █  █       █"
    	echo " █   █   █████   █  █  █         █     █  █████   █████"
    	echo "  █ █    █       █   █ █         █     █  █       █"
    	echo "   █     █       █    ██          █████   █       █"
    	echo ""
    	echo "Press any key to turn vpn on."
	read -rsn1 -t 2 KEY
	if [[ -n \$KEY ]]; then
	    STATE="ON"
	    break
	fi
    done
fi
done
EOF

chmod +x ./vpn.sh

tee ./.config.json 1>/dev/null <<EOF
{
  "region": "ir",
  "block-ads": false,
  "execute-config-as-is": false,
  "log-level": "warn",
  "resolve-destination": false,
  "ipv6-mode": "ipv4_only",
  "remote-dns-address": "udp://1.1.1.1",
  "remote-dns-domain-strategy": "",
  "direct-dns-address": "1.1.1.1",
  "direct-dns-domain-strategy": "",
  "mixed-port": 12334,
  "tproxy-port": 12335,
  "local-dns-port": 16450,
  "tun-implementation": "mixed",
  "mtu": 9000,
  "strict-route": true,
  "connection-test-url": "http://connectivitycheck.gstatic.com/generate_204",
  "url-test-interval": 600,
  "enable-clash-api": true,
  "clash-api-port": 16756,
  "enable-tun": true,
  "enable-tun-service": false,
  "set-system-proxy": false,
  "bypass-lan": false,
  "allow-connection-from-lan": false,
  "enable-fake-dns": false,
  "enable-dns-routing": true,
  "independent-dns-cache": true,
  "rules": [],
  "mux": {
    "enable": false,
    "padding": false,
    "max-streams": 8,
    "protocol": "h2mux"
  },
  "tls-tricks": {
    "enable-fragment": false,
    "fragment-size": "10-30",
    "fragment-sleep": "2-8",
    "mixed-sni-case": false,
    "enable-padding": false,
    "padding-size": "1-1500"
  },
  "warp": {
    "enable": false,
    "mode": "proxy_over_warp",
    "wireguard-config": "",
    "license-key": "",
    "account-id": "",
    "access-token": "",
    "clean-ip": "auto",
    "clean-port": 0,
    "noise": "1-3",
    "noise-size": "10-30",
    "noise-delay": "10-30",
    "noise-mode": "m6"
  },
  "warp2": {
    "enable": false,
    "mode": "proxy_over_warp",
    "wireguard-config": "",
    "license-key": "",
    "account-id": "",
    "access-token": "",
    "clean-ip": "auto",
    "clean-port": 0,
    "noise": "1-3",
    "noise-size": "10-30",
    "noise-delay": "10-30",
    "noise-mode": "m6"
  }
}
EOF
sleep 2

echo -e "Now put your vless or vmess server link into server.txt and run vpn.sh\n"
echo -e "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
sleep 6
