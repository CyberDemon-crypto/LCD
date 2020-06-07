#!/usr/bin/bash
# made by https://github.com/CyberDemon-crypto
sys=$(lsb_release -si)

case "$sys" in
  ManjaroLinux|ArchLinux)
    sys='pamac'
    conf='--no-confirm'
    ;;
  *)
    sys='apt-get'
    conf='-y'
    ;;
esac
clear
"$sys" update "$conf" && "$sys" upgrade "$conf"
packages=('imagemagick' 'vlc' 'nano' 'qpdfview' 'libreoffice' 'xarchiver' 'file')
for package in ${packages[*]}
  do
    "$sys" install "$package" "$conf"
  done

