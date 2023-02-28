export PATH=~/bin:/opt/bin:$PATH
export PS1='${debian_chroot:+($debian_chroot)}\u@\H:\w\$ '
export PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\H: \w\a\]$PS1"
export COMPOSER_ALLOW_SUPERUSER=1

alias dir='ls -al --color'
