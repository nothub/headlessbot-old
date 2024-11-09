#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

hmc() {
    docker run -it --rm \
        --name "headlessbot" \
        -p "127.0.0.1:8080:8080" \
        -v "${PWD}/mc:/work/.minecraft" \
        -v "${PWD}/hmc:/work/HeadlessMC" \
        "n0thub/headlessmc:${hmc_version}" \
        "${@}"
}

prop() {
    cat gradle.properties \
        | grep -E -m 1 "${1}"'\s*=' \
        | sed -E 's/^\w+\s*=\s*//'
}

hmc_version="$(prop 'headlessmc_version')"
mc_version="$(prop 'minecraft_version')"
fabric_version="$(prop 'fabric_loader_version')"

# workdir
cd "$(dirname "$(realpath "$0")")/.."
mkdir -p run
cd run

# msa login
if test ! -f "hmc/auth/.account.json"; then
    if test ! -f "../auth.json"; then
        set +o nounset
        if test -z "${1}" || test -z "${2}"; then
            echo "Usage: ${0} [<username> <password>]" >&2
            echo "Create auth.json or supply username and password arguments." >&2
            exit 1
        fi
        set -o nounset
        jq ".username = \"${1}\" | .password = \"${2}\"" ../auth.example.json > ../auth.json
    fi
    username="$(cat "../auth.json" | jq -r '.username')"
    password="$(cat "../auth.json" | jq -r '.password')"
    hmc login "${username}" "${password}"
fi

# download mc
if test ! -e "mc/versions/${mc_version}"; then
    hmc download "${mc_version}"
fi

# download fabric
if test -z "$(find './mc/versions/' -maxdepth 1 -name 'fabric-loader-*-1.20.4' -print)"; then
    hmc fabric "${mc_version}"
fi

# download mods
mkdir -p "mc/mods"
mods=$(jq -r '.mods' "../mods.json")
for mod in $(echo "$mods" | jq -c '.[]'); do
    file=$(basename "$(echo "$mod" | jq -r '.url')")
    url=$(echo "$mod" | jq -r '.url')
    sha256=$(echo "$mod" | jq -r '.sha256')
    if test ! -e "mc/mods/${file}"; then
        echo "fetching ${file} from ${url}"
        curl -sSL -o "mc/mods/${file}" "${url}"
        echo "${sha256} mc/mods/${file}" | sha256sum -c -
    fi
done

(
    cd ..

    # build our mod
    ./gradlew --console=plain --info --full-stacktrace clean check build

    # install our mod
    cp ./build/libs/headlessbot.jar run/mc/mods/
)

# launch bot
hmc "launch 1 -id"
