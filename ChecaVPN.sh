#!/bin/sh

#SCRIPT CHECAGEM CONEXAO VPN E INTERNET / JAN 2020

VPNSERVER=`ifconfig tunSmart | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | head -1`
VPNNAME=`ifconfig | egrep tun | awk '{print $1}'`
DATE=`date +%Y-%m-%d:%H:%M:%S`

/bin/ping -w2 8.8.8.8 > /dev/null

if [ $? != 0 ]
then echo "$DATE - internet indisponivel" >> /var/log/validacaolink.log;
exit 0
else
        if  ! /sbin/ifconfig $VPNNAME | grep -q "tunSmart";
        then
                echo "$DATE - interface $VPNNAME DOWN" >> /var/log/validacaolink.log;
                /etc/init.d/openvpn restart 
                exit 0
        else
                if ! /bin/ping -w2 $VPNSERVER > /dev/null;
                then
                        echo "$DATE - VPN DOWN" >> /var/log/validacaolink.log;
                        /etc/init.d/openvpn restart
                else
                        echo "$DATE - VPN UP" >> /var/log/validacaolink.log;
                fi
        fi
fi
#MELHORADO
#!/bin/sh

#SCRIPT CHECAGEM CONEXAO VPN E INTERNET / JAN 2020

VPNSERVER=`ifconfig tunSmart | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | head -1`
VPNNAME=`ifconfig | egrep -B1 "P-a-P" | awk '{print $1}' | head -1`
DATE=`date +%Y-%m-%d:%H:%M:%S`

/bin/ping -w2 8.8.8.8 > /dev/null
[[ $? != 0 ]] && echo "$DATE - internet indisponivel" >> /var/log/validacaolink.log && exit 0

if  ! /sbin/ifconfig $VPNNAME | grep -q "tunSmart";
        then
                echo "$DATE - interface $VPNNAME DOWN" >> /var/log/validacaolink.log;
                /etc/init.d/openvpn restart
                exit 0
else
/bin/ping -w2 $VPNSERVER > /dev/null
[[ $? != 0 ]] && echo "$DATE - VPN DOWN" >> /var/log/validacaolink.log && /etc/init.d/openvpn restart && exit 0
fi