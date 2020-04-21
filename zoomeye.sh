#!/usr/bin/bash
clear
function banner(){
	echo -e "_________________________"
	echo -e "TOOLS SCANNING PROXY"
	echo -e "Author: Andreas Asatera"
	echo -e "@andreas_nofa"
	echo -e "_________________________"
	echo -e "zoomeye.org | Version:1.0\n\n"
}
banner

printf "Masukkan url universitas?: "
read universitas;
ip=$(dig +short $universitas | awk '{ print ; exit }')
# json=$(curl -# "https://api.shodan.io/shodan/host/{${ip}}?key={OZi7Lq6PPz8B15jO1nFa1Hagt5NulEBI}")
# result=$(echo $json | jq ".data | .[]")
# host=$(echo $result | jq ".http.host" | sed -e 's/"//g' | awk {'print "Proxy: " $1,$2'})
# port=$(echo $result | jq ".port" | sed -e 's/"//g' | awk {'print "Port: " $1,$2'})
# status=$(echo $result | jq ".data" | sed -e 's/"//g' | grep -Eo "HTTP.*" | cut -d "\\" -f1 | awk {'print "Status: " $1,$2'})
# echo -e "\n$host"
# echo -e "\n$port"
# echo -e "\n$status"=

echo -e "\n(login ke server)"
json=$(curl -# -X POST https://api.zoomeye.org/user/login -d '{ "username": "ryusuke005@gmail.com", "password": "1q0cBUV1VN7w" }')
access_token=$(echo $json | jq ".access_token" | sed -e 's/"//g')

echo -e "\n(mencari proxy)"
query=$(curl -# -X GET "https://api.zoomeye.org/host/search?query=ip:$ip" -H "Authorization: JWT $access_token")
result=$(echo $query | jq ".matches | .[]")
host=$(echo $result | jq ".ip" | sed -e 's/"//g' | awk {'print "Proxy: " $1,$2'})
port=$(echo $result | jq ".portinfo | .port" | sed -e 's/"//g' | awk {'print "Port: " $1,$2'})
app=$(echo $result | jq ".portinfo | .app" | sed -e 's/"//g' | awk {'print "App: " $1,$2'})
banner=$(echo $result | jq ".portinfo | .banner" | sed -e 's/"//g' | grep -Eo "HTTP.*" | cut -d "\\" -f1 | awk {'print "Response: " $1,$2'})
echo -e "\n$host"
echo -e "\n$port"
echo -e "\n$app"
echo -e "\n$banner"
