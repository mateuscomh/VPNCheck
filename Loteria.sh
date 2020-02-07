#!/bin/bash
echo "Tente acertar o número "
echo "Dica: Ele está entre 10 e 50. "
i=1
while true
do
	echo "Digite o Número: "
	read num
		if [ $num != 30 ]
		then
			echo "Você errou. Tente outra vez"
			let i++
			continue
		fi
	if [ $num == 30 ] | [ $i == 1 ]
 	 then
		 echo "Voce acertou de primeira"
		 break
	fi
	if [ $num == 30 ]
	then
		echo "Voce acertou após $i tentativas"
		break
	fi
done
