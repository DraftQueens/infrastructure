#!/bin/bash

set -exuo pipefail
IFS=$'\n\t'

quietadduser () {
  adduser --gecos '' --disabled-password $1
}

addkey () {                                                                     
  sudo -u $1 echo $2 >> /home/$1/.ssh/authorized_keys
}                                                                               

mkdir /etc/skel/.ssh/
touch /etc/skel/.ssh/authorized_keys

# users
quietadduser ${dolan-name}
quietadduser ${ben-name}
quietadduser ${eddie-name}

# keys
addkey ${dolan-name} '${dolan-key}'

