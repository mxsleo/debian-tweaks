#!/usr/bin/env bash
set -euxo pipefail


# Functions +++

function debian_go_testing()
{
    local _sources_list="$(
        cat <<- "EOF"
		deb http://deb.debian.org/debian testing main contrib non-free non-free-firmware
		deb-src http://deb.debian.org/debian testing main contrib non-free non-free-firmware

		deb http://deb.debian.org/debian-security/ testing-security main contrib non-free non-free-firmware
		deb-src http://deb.debian.org/debian-security/ testing-security main contrib non-free non-free-firmware

		deb http://deb.debian.org/debian testing-updates main contrib non-free non-free-firmware
		deb-src http://deb.debian.org/debian testing-updates main contrib non-free non-free-firmware
		EOF
    )"

    echo "${_sources_list}" | sudo tee /etc/apt/sources.list > /dev/null

    sudo apt update
    sudo apt full-upgrade --yes
    sudo apt autoremove --yes
    sudo apt autoclean
}

# Functions ---


# Main +++

debian_go_testing

# Main ---
