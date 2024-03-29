#!/usr/bin/env bash

# See https://www.r15cookie.com/info/scripting/
# License: MIT

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)


usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] -p param_value arg1 [arg2...]
Script description here.
Available options:
-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-f, --flag      Some flag description
-p, --param     Some param description
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
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
  # default values of variables set from params
  flag=0
  param=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -f | --flag) flag=1 ;; # example flag
    -p | --param) # example named parameter
      param="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
  [[ -z "${param-}" ]] && die "Missing required parameter: param"
  [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

#parse_params "$@"
setup_colors


msg "${RED}WARNING!  This script has NOT been test!${NOFORMAT}"
msg "If you agree, press enter to continue"
read nothing

# Chome


msg "${YELLOW}Manual:${NOFORMAT} Please go to https://google.com/chrome and download/install Chrome"
msg "Prell ${GREEN}Enter${NOFORMAT} when complete to continue"

# X code and command line tools

msg "${YELLOW}Manual:${NOFORMAT} Please go to https://developer.apple.com/downloads and download Command Line Tools for XCode"
msg "Prell ${GREEN}Enter${NOFORMAT} when complete to continue"

if [ ! -r $HOME/.ssh/id_rsa ]; then
  ssh-keygen  -b 4096
fi

# Add ssh to keychain
ssh-add --apple-use-keychain

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install --cask visual-studio-code


# Main path to docker/kubernetes, this this may also install https://github.com/lima-vm/lima but may have to check.
# TODO: Investigate colima a little harder as a replacement for Docker for Desktop - RW volume mounts seems slightly tricky
#brew install colima docker kubectl

brew install --cask docker


# Utilities I really want on the desktop
brew install --cask iterm2 jq
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash

# Github cli
brew install gh

# Fix paths
sudo launchctl config user path "$(brew --prefix)/bin:${PATH}"
msg "${RED}Reboot:{$NOCOLOR} to enable brew path support in Mac GUI apps"

