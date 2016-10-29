#!/bin/bash
shopt -s nocaseglob
clear
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

function run {
  clear
  printf "Running VitaBrickCheck for all files:\n"

  for vpk in *.vpk
  do
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    printf "\n"
    sh ../VitaBrickCheck/VitaBrickCheck.sh "$vpk"
  done

  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ━
}

function quit {
  printf "\nStopping...\n"
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ━
  exit
}

for vpk in *.vpk
do
  size=$(du -m "$vpk" | cut -f 1)
  printf "$vpk | ${size}MB\n"
done

printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ━

vpkCount=${#vpk[@]}

printf "Do you want to check the $vpkCount above VPK file(s)?\n"
printf "This may take a while.\n\n"

select yn in "Yes" "No"; do
  case $yn in
      Yes ) run; break;;
      No ) quit; break;;
  esac
done

read -rsp $'COMPLETE!\nScroll up for the results.\n\nPush any key to end...' -n 1 key
