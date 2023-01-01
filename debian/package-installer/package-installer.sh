#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

check_root() {
  if [ "$(id -u)" != "0" ]
  then
    printf "${RED}Error:${NC} This script must be run as root.\n" 1>&2
    exit 1
  fi
}

is_installed() {
  dpkg -s "$1" > /dev/null 2>&1
}

is_available() {
  apt-cache show "$1" > /dev/null 2>&1
}

install_package() {
  printf "${YELLOW}%s: ${NC}" "$1"

  apt-get -y install "$1" &>/dev/null

  if [ $? -eq 0 ]
  then
    printf " ${GREEN}\u2714${NC}\n"
  else
    printf "${RED}\u2718${NC}\n"
  fi
}

install_packages() {
  while read package
  do
    if ! is_installed "$package"
    then
      if is_available "$package"
      then
        install_package "$package"
      else
        printf "${YELLOW}Warning:${NC} Package %s is not available in the repositories.\n" "$package" 1>&2
      fi
    else
      printf "${GREEN}Package %s is already installed${NC}.\n" "$package"
    fi
  done < packages.txt
}

check_packages_file() {
  if [ ! -f "packages.txt" ]
  then
    printf "${RED}Error:${NC} The file packages.txt does not exist.\n" 1>&2
    exit 1
  fi
}

check_packages_file_permissions() {
  if [ ! -r "packages.txt" ]
  then
    printf "${RED}Error:${NC} The file packages.txt is not readable.\n" 1>&2
    exit 1
  fi
}

main() {
  check_root
  check_packages_file
  check_packages_file_permissions
  install_packages
  printf "${GREEN}Done!${NC}\n"
}

main
