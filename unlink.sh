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

header "Removing symlinks to dotfiles from home folder..."
cd ~/.dotfiles
stow -D .
footer "Done"
