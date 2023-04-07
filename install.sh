#!/bin/bash

function header()
{
  local font_yellow="\033[93m"
  local font_bold="\033[1m"
  local font_end="\033[0m"
  echo -e "\n${font_yellow}${font_bold}${1}${font_end}"
}

function footer()
{
  local font_white="\033[97m"
  local font_bold="\033[1m"
  local font_end="\033[0m"
  echo -e "${font_white}${font_bold}${1}${font_end}"
}

function get_distro()
{
  if [[ -f /etc/os-release ]]
  then
    source /etc/os-release
    echo $ID
  else
    uname
  fi
}

clear

if [ "$(get_distro)" == "neon" ]; then
  header "OS Detected: KDE Neon"
  header "Updating APT Repositories"
  sudo apt update
  INSTCMD="sudo apt install -y"
  footer "Done"
elif [ "$(get_distro)" == "pop" ]; then
  header "OS Detected: Pop!_OS"
  header "Updating APT Repositories"
  sudo apt update
  INSTCMD="sudo apt install -y"
  footer "Done"
elif [ "$(get_distro)" == "ubuntu" ]; then
  header "OS Detected: Ubuntu"
  header "Updating APT Repositories"
  sudo apt update
  INSTCMD="sudo apt install -y"
  footer "Done"
elif [ "$(get_distro)" == "debian" ]; then
  header "OS Detected: Debian"
  header "Updating APT Repositories"
  sudo apt update
  INSTCMD="sudo apt install -y"
  footer "Done"
elif [ "$(get_distro)" == "raspbian" ]; then
  header "OS Detected: Raspbian"
  header "Updating APT Repositories"
  sudo apt update
  INSTCMD="sudo apt install -y"
  footer "Done"
elif [ "$(get_distro)" == "alpine" ]; then
  header "OS Detected: Alpine"
  header "Updating APK Repositories"
  sudo apk update
  INSTCMD="sudo apk add --update"
  footer "Done"
else
  echo "Error: You are not using a supported distribution!!"
  echo "Currently only derivatives of Ubuntu/Debian, Fedora and Alpine is supported."
  exit 1
fi

header "Installation Command:"
footer "$INSTCMD package-name"

header "Checking if git is installed..."
if [ -z "$(command -v git)" ]; then
  footer "Package git is not installed. Installing..."
  $INSTCMD git
  footer "Done"
else
  footer "Package git is installed."
  footer "Progressing..."
fi

header "Checking if stow is installed..."
if [ -z "$(command -v stow)" ]; then
  footer "Package stow is not installed. Installing..."
  $INSTCMD stow
  footer "Done"
else
  footer "Package stow is installed."
  footer "Progressing..."
fi

header "Cloning dotfiles repository..."
if [ -d ~/.dotfiles/.git ]; then
  footer "Local dotfiles repository exists. Updating..."
  cd ~/.dotfiles
  git pull
else
  footer "Local dotfiles repository not present. Cloning..."
  git clone git@github.com:ozayturay/dotfiles.git ~/.dotfiles
fi
footer "Done"

header "Creating symlinks from dotfiles..."
cd ~/.dotfiles
stow .
footer "Done"
