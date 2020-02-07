#!/bin/sh
###############################
#
#
#SCRIPT CHECAGEM CONEXAO VPN E INTERNET 
#Versão 1.1 - Promovida implementação para qualquer cliente CentoOS6
#Homologado em Clientes CENTOS6
#

###############################

VPNSERVER=`ifconfig tunSmart | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | head -1`
VPNNAME=`ifconfig | egrep -B1 "P-a-P" | awk '{print $1}' | head -1`
DATE=`date +%Y-%m-%d:%H:%M:%S`
INTERNETLINK=8.8.8.8

#Validar disponibilidade da internet
/bin/ping -w2 $INTERNETLINK > /dev/null
[[ $? != 0 ]] && echo "$DATE - internet indisponivel" >> /var/log/validacaolink.log && exit 0
#Validar se interface de VPN está UP
if  ! /sbin/ifconfig $VPNNAME | grep -q "tunSmart";
then
	echo "$DATE - interface $VPNNAME DOWN" >> /var/log/validacaolink.log;
	/etc/init.d/openvpn restart
	exit 0
else
#Validar se VPN está trafegando
	/bin/ping -w2 $VPNSERVER > /dev/null
	[[ $? != 0 ]] && echo "$DATE - VPN DOWN" >> /var/log/validacaolink.log && /etc/init.d/openvpn restart 
fi
