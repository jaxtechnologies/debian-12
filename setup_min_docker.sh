#!/usr/bin/env bash
# NAME: JTOS
# DESC: An installation and deployment script for JaxTech's Mint Cinnamon desktop.
# Adapted from Derek Taylor's (DistroTube) DTOS script...
# Top logo inspiration came from Chris Titus's ArchTitus script...

clear

echo -ne "
   ████████╗  █████╗  ██╗   ██╗  ████████╗ ███████╗  ██████╗ ██╗  ██╗
   ╚══██╔══╝ ██╔══██╗  ██╗ ██╔╝  ╚══██╔══╝ ██╔════╝ ██╔════╝ ██║  ██║
      ██║    ███████║   ████╔╝      ██║    ███████╗ ██║      ███████║
   ██ ██║    ██╔══██║  ██╔╝██╗      ██║    ██╔════╝ ██║      ██╔══██║
   ╚███╔╝    ██║  ██║ ██╔╝  ██╗     ██║    ███████╗ ╚██████╗ ██║  ██║
    ╚══╝     ╚═╝  ╚═╝ ╚═╝   ╚═╝     ╚═╝    ╚══════╝  ╚═════╝ ╚═╝  ╚═╝
"
echo " JTOS script will launch in 5 seconds..."

sleep 5

if [[ $EUID -ne 0 ]]; then
  clear
  echo ""
  echo "You must be root to run this script" 2>&1
  exit 1
else

echo “you are currently root”
fi

install_path=$(pwd)

read -p "Do you have a primary non-priviledged user that needs classic VIM  (y/n)?"
	if [ "$REPLY" = "y" ]; then
      echo “What is the primary username”
	   read primary_user
	else
			cancel
	fi 

apt update
apt upgrade -y

apt install vim -y
apt install dos2unix -y
apt install docker.io -y
apt install docker-compose -y
echo "set mouse-=a" >> ~/.vimrc
echo "set mouse-=a" >> /home/$primary_user/.vimrc
usermod -G docker $primary_user
echo "alias ll='ls $LS_OPTIONS -l'" >> ~/.bashrc
echo "alias ll='ls $LS_OPTIONS -l'" >> /home/$primary_user/.bashrc
echo "alias ha='cd /opt/homeassistant/config/'" >> ~/.bashrc
echo "alias ha='cd /opt/homeassistant/config/'" >> /home/$primary_user/.bashrc

clear
echo ""
read -p "Is this a Dual Boot Machine where the Grub Menu is needed to control the OS... (y/n)? "
if [ "$REPLY" = "n" ]; then

  echo ""
  echo Modifying Grub Menu to not display...  Please be patient...
  echo ""
  echo ""
  sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
  update-grub

else
        cancel
fi

clear
echo ""
read -p "Setup is Complete - Reboot the Machine NOW (y/n)? "
if [ "$REPLY" = "y" ]; then

  reboot

else
        cancel
fi

exit
