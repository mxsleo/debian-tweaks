#!/usr/bin/env bash
set -euxo pipefail


# Global variables +++

_VBOX_VER="7.0"

# Global variables ---


# Functions +++

function debian_setup_virtualbox_key()
{
    wget --verbose --no-clobber --output-document=- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --output /etc/apt/keyrings/oracle-virtualbox-2016.gpg
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

    echo "${_sources_list_virtualbox}" | sudo tee /etc/apt/sources.list.d/oracle-virtualbox.list > /dev/null

    sudo apt update
}

function debian_setup_virtualbox_repository()
{
    sudo apt install --yes "virtualbox-${_VBOX_VER}"
}

# Functions ---


# Main +++

debian_setup_virtualbox_key
debian_setup_virtualbox_repository
debian_setup_virtualbox

# Main ---
