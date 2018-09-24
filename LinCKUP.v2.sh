#!/bin/bash
# Script de BACKUP com confirmação via e-mail.
# Marta Laís, 2018. GASiS3 (c)


# Identifique qual o seu HD para backup e substitua /dev/sdc* por ele.
# /mnt/BACKUP eh o caminho onde o HD de backuo sera montado, substitua por um de sua escolha.
mount /dev/sdc* /mnt/BACKUP

# montado checa se o HD foi montado corretamente.
# Substitua "/sdc5" pelo caminho do seu HD de backup.
montado=`mount | grep /mnt/sdc5`

# Substitua pelo seu email.
EMAIL=`your@email.com`

if [ -z "$montado" ]; then

	echo "ERROR: Unable to mount."

	# Envio de email caso erro.
	sendemail -f "$EMAIL" -t "$EMAIL" -u "Backup." -m "Backup failed!" -s smtp.gmail.com:587 -xu "$EMAIL" -xp <passwd>
	exit 1

else
	echo "Mounted!"
	DATA=`date +%Y-%m-%d-%H.%M`
	
	# Substitua pelo local onde o HD foi montado.
	cd /mnt/BACKUP

	# Subsbtitua "/vbox" pelo caminho dos dados a serem copiados como backup. 
	tar -zcvf BACKUP_"$DATA".tar.gz /vbox/.../
	umount /mnt/sd*

	# Envio de email caso sucesso. 
	# Substitua <PASSWORD> pela senha do email.
	sendemail -f "$EMAIL" -t "$EMAIL" -u "Backup." -m "
Backup made successfully!" -s smtp.gmail.com:587 -xu "$EMAIL" -xp <PASSWORD>
fi
