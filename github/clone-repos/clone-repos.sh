#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

check_utilities() {
  if ! [ -x "$(command -v curl)" ] || ! [ -x "$(command -v git)" ]
  then
    printf "${RED}Error:${NC} curl and git are required to run this script.\n"
    exit 1
  fi
}

get_username() {
  read -p "Enter your GitHub username: " username

  if [ -z "$username" ]
  then
    printf "${RED}Error:${NC} No username was entered. Exiting.\n"
    exit 1
  fi
}

get_protocol() {
  read -p "Clone using HTTP or SSH? (Enter 'http' or 'ssh') " protocol

  if [ "$protocol" != "http" ] && [ "$protocol" != "ssh" ]
  then
    printf "${RED}Error:${NC} Invalid protocol. Exiting.\n"
    exit 1
  fi
}

get_repos() {
  if  [ "$protocol" == "http" ]
  then
    repos=$(curl -s "https://api.github.com/users/$username/repos?per_page=100" | grep 'clone_url' | awk '{print $2}' | sed 's/"\(.*\)",/\1/')
  else
    repos=$(curl -s "https://api.github.com/users/$username/repos?per_page=100" | grep 'ssh_url' | awk '{print $2}' | sed 's/"\(.*\)",/\1/')
  fi
  
  if [ $? -ne 0 ]
  then
    printf "${RED}Error:${NC} Failed to get list of repositories from GitHub API.\n"
    exit 1
  fi

  if [ -z "$repos" ]
  then
    printf "${RED}Error:${NC} No repositories found for user $username. Exiting.\n"
    exit 1
  fi
}

clone_repos() {
  for repo in $repos
  do
    repo_name=$(echo "$repo" | sed 's/.*\///' | sed 's/\.git//')

    printf "${GREEN}Cloning repository $repo_name...${NC}\n"

    git clone "$repo"

    if [ $? -ne 0 ]
    then
      printf "${RED}Error:${NC} Failed to clone repository $repo_name.\n"
    fi
  done
}

main() {
  check_utilities
  get_username
  get_protocol
  get_repos
  clone_repos
  printf "${GREEN}Done!${NC}\n"
}

main
