#!/bin/bash
#Decided to rewrite this using ipconfig ... because ... why not.
#get external ip
external=$(curl -s www.icanhazip.com | awk {'print $1'})
#Check Ethernet and Wifi/Airport/WWAN for ipv4 internal addresses
internal0=$(ipconfig getifaddr en0)
internal1=$(ipconfig getifaddr en1)
internal2=$(ipconfig getifaddr en2)
internal3=$(ipconfig getifaddr en3)
internal4=$(ipconfig getifaddr en4)
#Check Eth, and Wifi/Airport for ipv6 addresses
#internal2=$(ifconfig en5 | grep "inet6" | grep -v fe80:: | cut -d " " -f 2)
#internal3=$(ifconfig en1 | grep "inet6" | grep -v fe80:: | cut -d " " -f 2)
#Get VPN, and and Virtual Interfaces
vpn0=$( ifconfig ppp0 |grep "inet" | grep -v 127.0.0.1 | cut -d " " -f 2)
vmnic0=$( ifconfig vnic0 | grep "inet" | grep -v inet6 |cut -d " " -f 2)
vpn1=$(ifconfig utun1 | grep inet | cut -d ' ' -f 2)
#Get VlanID and Vlan IP
vlan0=$(ifconfig vlan0 | grep "vlan:" | cut -d " " -f 2 )
vlan0ip=$(ifconfig vlan0 | grep "inet" | grep -v inet6 |cut -d " " -f 2)
vlan1=$(ifconfig vlan1 | grep "vlan:" | cut -d " " -f 2 )
vlan1ip=$(ifconfig vlan1 | grep "inet" | grep -v inet6 |cut -d " " -f 2)
ssid=$(networksetup -getairportnetwork en1 | awk -F": " '{print $2}')
#display external
echo "External : ${external}"
#display Internal ipv4 from wifi, ethernet or both

if [ "${internal0}" != "" ]; then
    echo "WWANLTE : ${internal0}"
fi
if [ "${internal1}" != "" ]; then
    echo "${ssid} : ${internal1}"
fi
if [ "${internal8}" != "" ]; then
    echo "DeskUSBEth : ${internal8}"
fi
if [ "${internal9}" != "" ]; then
    echo "USBEth : ${internal9}"
fi
if [ "${internal10}" != "" ]; then
    echo "USBEth : ${internal10}"
fi
if [ "${internal2}" != "" ]; then
    echo "USBEth : ${internal2}"
fi
#display ipv6 from wifi, ethernet or both
#if [ "${internal2}" != "" ]; then
#    echo "IPv6 : ${internal2}"
#fi
#if [ "${internal3}" != "" ]; then
#    echo "IPv6 : ${internal3}"
#fi
#display VZW ipv4
if [ "${vpn0}" != "" ]; then
        echo "VZW: ${vpn0}"
fi
if [ "${vmnic0}" != "" ]; then
        echo "VMWare: ${vmnic0}"
fi
#display Vlanid's and associate IP
if [ "${vlan0ip}" != "" ]; then
        echo VLAN"${vlan0}: ${vlan0ip}"
fi
if [ "${vlan1ip}" != "" ]; then
        echo "${vlan1}: ${vlan1ip}"
fi
if	[ "${vpn1}" != "" ] ; then
		echo "MicrosofVPN:${vpn1}"
fi