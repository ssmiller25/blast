#!/usr/bin/env bash

# Template from https://gist.github.com/m-radzikowski/53e0b39e9a59a1518990e76c2bff8038

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

install="false"  # User will need to enable to allow installation
os_type_detected="none"  # Should be over-written
deb_release=""  # Get around PopOS having weird release

# shellcheck disable=SC2034
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-i]

Setup base immutable desktop environment for *nix like environments.  
Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-i, --install   Install any non-detected software              

EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}


setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    # shellcheck disable=SC2034
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    # shellcheck disable=SC2034
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}


die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}


parse_params() {
  
  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -i | --install ) install="true" ;; # allow installation
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  return 0
}

install_docker_gen() {
  # Source - https://github.com/Budibase/budibase/blob/master/hosting/scripts/linux/install-docker.sh
  local tempdir
  tempdir=$(mktemp)
  mkdir "${tempdir}"
  curl -fsSL https://get.docker.com -o "${tempdir}/get-docker.sh"
  sudo sh "${tempdir}/get-docker.sh"
}

install_docker_chomeos() {
  
  # Based on echo "Go to https://dvillalobos.github.io/2020/How-to-install-and-run-Docker-on-a-Chromebook/ to install docker on ChromeOS" 
  #  But just using for all debina/ubuntu bases

  sudo apt-get update
  sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common 
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88 || die "Keyprint 0EBFCD88 not imported correctly"
  sudo add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   ${deb_release} \
   stable"
  sudo apt-get update
  sudo apt-get -y install docker-ce docker-ce-cli containerd.io

}

os_detect() {
  local lsb_desc
  lsb_desc=$(lsb_release -d)
    if [ -d /mnt/chromeos ]; then
      msg "${BLUE}ChromeOS detected.${NOFORMAT}"
      os_detected="chromeos"
      os_type_detected="debian"
      deb_release=$(lsb_release -cs)
    elif echo "${lsb_desc}" | grep -qi pop; then
      msg "${BLUE}PopOS (Ubuntu) detected.${NOFORMAT}"
      os_detected="popos"
      os_type_detected="debian"
      deb_release="buster"
    elif echo "${lsb_desc}" | grep -qi debian; then
      msg "${BLUE}Debian detected.${NOFORMAT}"
      os_detected="debian"
      os_type_detected="debian"
      deb_release=$(lsb_release -cs)
    elif echo "${lsb_desc}" | grep -qi ubuntu; then
      msg "${BLUE}Ubuntu detected.${NOFORMAT}"
      os_detected="ubuntu"
      os_type_detected="debian"
      deb_release=$(lsb_release -cs)
    else
      msg "${RED}Unknown OS:${NOFORMAT} ${lsb_desc}"
    fi

}

verify_docker() {
  if command -v docker > /dev/null 2>&1; then
    msg "${BLUE}Docker Detected:${NOFORMAT} Continuing"
    return 0
  elif [ "$install" == "false" ]; then 
    msg "${RED}Docker NOT detected, and install flag not passed.${NOFORMAT}"
  else
    if [ "${os_detected}" == "chromeos" ]; then
      msg "${BLUE}Installing docker${NOFORMAT}"
      install_docker_chomeos
    elif [ "${os_type_detected}" == "debian" ] ; then
      msg "${BLUE}Installing docker${NOFORMAT}"
      install_docker_gen
    else
      msg "${BLUE}Installing docker - generic${NOFORMAT}"
      install_docker_gen
    fi
  fi
}

### Main


parse_params "$@"
setup_colors

os_detect

# Verify, and install docker
verify_docker
