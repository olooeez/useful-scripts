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

set_base_url() {
  if [ "$protocol" == "http" ]
  then
    base_url="https://github.com"
  else
    base_url="git@github.com"
  fi
}

get_repos() {
  repos=$(curl -s "https://api.github.com/users/$username/repos?per_page=100" | grep 'clone_url' | awk '{print $2}' | sed 's/"\(.*\)",/\1/')

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

create_repo_dir() {
  if [ -d "$repo_dir" ]
  then
    read -p "Directory $repo_dir already exists. Enter 'y' to overwrite, or any other key to cancel: " overwrite

    if [ "$overwrite" != "y" ]
    then
      printf "${YELLOW}Exiting.${NC}"
      exit 1
    fi

    rm -rf "$repo_dir"
  fi

  mkdir "$repo_dir"
}

clone_repos() {
  cd "$repo_dir"

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
  set_base_url
  get_repos
  create_repo_dir
  clone_repos
  printf "${GREEN}Done!${NC}\n"
}

main
