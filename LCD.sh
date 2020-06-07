#!/usr/bin/bash
# made by https://github.com/CyberDemon-crypto
cd "$HOME" && mkdir cyberdemon
cd cyberdemon && mkdir LCD
cd LCD && mkdir Settings
function menu() {
  cur="$1"  # Current directory
  filename="$HOME/cyberdemon/LCD/Settings/folder.txt"
  cd "$cur"
  clear
  ls > "$HOME/cyberdemon/LCD/Settings/folder.txt"
  index=0
  printf "[\u001b[31m0\u001b[0m]Back\u001b[1B\u001b[1000D$(pwd)"
  echo
  while read line   # Displaying ls
    do
      index=$((index+1))
      printf "\u001b[1000D[\u001b[35m%s$index\u001b[0m]\u001b[32m%s$line\u001b[0m"
      echo
    done < "$filename"
  printf '\u001b[1000D$ '
  read -r file

  if [ "$file" = 0 ]  # Move back
    then menu ".."
  fi
  index=1
  while read line
    do
      if [ "$file" = "$index" ]
        then file="$line"
        break
      fi
      index=$((index+1))
    done < "$filename"
  file "$file" > "$HOME/cyberdemon/LCD/Settings/file.txt"
  actions=('directory' 'image' 'Audio' 'MP4' 'WebM' 'Matroska' 'archive' 'PDF' 'Microsoft' 'OpenDocument' 'text' 'empty')   # File types
  for item in ${actions[*]}
    do
      if [ "$(grep -o "$item" "$HOME/cyberdemon/LCD/Settings/file.txt")" != '' ]
        then action=$(grep -o "$item" "$HOME/cyberdemon/LCD/Settings/file.txt")
      fi
    done
      case $action in
        'directory')  # Folder
          menu "$file"
          ;;
        'image')  # Image
          display "$file"
          menu "$cur"
          ;;
        'Audio')  # Audio
          mpg123 -q "$file"
          menu "$cur"
          ;;
        'MP4'|'WebM'|'Matroska')  # Video
          vlc -q "$file"
          menu "$cur"
          ;;
        'text'|'empty')  # Text
          nano "$file"
          menu "$cur"
          ;;
        'archive')  # Archive
          xarchiver "$file"
          menu "$cur"
          ;;
        'PDF') # PDF
          qpdfview "$file"
          menu "$cur"
          ;;
        'Microsoft'|'OpenDocument')   # LibreOffice
          libreoffice "$file"
          menu "$cur"
          ;;
        *)
          menu "$cur"
      esac
}
# Change it to change the home folder
menu "$HOME"
