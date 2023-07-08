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

    echo "${_sources_list}" | tee /etc/apt/sources.list > /dev/null

    apt update
    apt full-upgrade --yes
    apt autoremove --yes
    apt autoclean
}

# Functions ---


# Main +++

if [[ "$(id -u)" -ne 0 ]]
then
    echo "The script must be run as root"
    read -rsp "Press Enter to continue..."
    exit 1
fi

debian_go_testing

# Main ---
