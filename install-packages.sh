#! /usr/bin/env bash

set -o pipefail
set -o errexit

. /etc/os-release

OS=$ID

if [ "${OS}" == "manjaro" ]; then
  ./install-packages-manjaro.sh
elif [ "${OS}" == "ubuntu" ]; then
  ./install-packages-ubuntu.sh
fi 
