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


install_path=$(pwd)

apt update
apt upgrade -y

apt install openssh-server -y
apt install vim -y
echo "set mouse-=a" >> ~/.vimrc
apt install dos2unix -y
apt install docker.io -y
apt install docker-compose -y

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
