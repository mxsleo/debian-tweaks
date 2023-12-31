#!/usr/bin/env bash
set -euxo pipefail


# Global variables +++

_VBOX_VER="7.0"

# Global variables ---


# Functions +++

function debian_setup_virtualbox_key()
{
    wget --verbose --no-clobber --output-document=- https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor --output /etc/apt/keyrings/oracle-virtualbox-2016.gpg
}

function debian_setup_virtualbox_repository()
{
    local _sources_list_virtualbox="$(
        cat <<- "EOF"
		deb [arch=amd64 signed-by=/etc/apt/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bullseye contrib
		deb http://deb.debian.org/debian bullseye main
		deb http://deb.debian.org/debian-security/ bullseye-security main
		EOF
    )"

    echo "${_sources_list_virtualbox}" | tee /etc/apt/sources.list.d/oracle-virtualbox.list > /dev/null

    apt update
}

function debian_setup_virtualbox_repository()
{
    apt install --yes "virtualbox-${_VBOX_VER}"
}

# Functions ---


# Main +++

if [[ "$(id -u)" -ne 0 ]]
then
    echo "The script must be run as root"
    read -rsp "Press Enter to continue..."
    exit 1
fi

debian_setup_virtualbox_key
debian_setup_virtualbox_repository
debian_setup_virtualbox

# Main ---
