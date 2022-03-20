#!/bin/bash

# Current Version: 1.0.7

## How to get and use?
# git clone "https://github.com/hezhijie0327/Patch.git" && bash ./Patch/release.sh

## Parameter
export ADGUARDHOME_VERSION_FIXED=""
export ARIA2_VERSION_FIXED=""
export C_ARES_VERSION_FIXED=""
export EXPAT_VERSION_FIXED=""
export GOLANG_VERSION_FIXED=""
export GPERFTOOLS_VERSION_FIXED=""
export LIBSSH2_VERSION_FIXED=""
export LIBUV_VERSION_FIXED=""
export NODEJS_VERSION_FIXED=""
export OPENSSL_VERSION_FIXED=""
export SQLITE_VERSION_FIXED=""
export SQLITE_YEAR_FIXED=""
export ZLIB_NG_VERSION_FIXED=""

## Function
# Get AdGuard Home Package Version
function GetAdGuardHomePackageVersion() {
    function GetAdGuardHomeCurrentPackageVersion() {
        if [ -f "./package.json" ]; then
            ADGUARDHOME_CURRENT=$(cat "./package.json" | jq -Sr ".adguardhome.version")
            GOLANG_CURRENT=$(cat "./package.json" | jq -Sr ".adguardhome.binary.version.golang")
            NODEJS_CURRENT=$(cat "./package.json" | jq -Sr ".adguardhome.binary.version.nodejs")
        fi
    }
    function GetAdGuardHomeLatestPackageVersion() {
        ADGUARDHOME_LATEST=$(curl -s --connect-timeout 15 "https://api.github.com/repos/AdguardTeam/AdGuardHome/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "-" | grep "^refs/tags/v" | tail -n 1 | sed "s/refs\/tags\/v//")
        GOLANG_LATEST=$(curl -s --connect-timeout 15 "https://api.github.com/repos/golang/go/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "[a-z]$" | grep "^refs/tags/go" | tail -n 1 | sed "s/refs\/tags\/go//")
        NODEJS_LATEST=$(curl -s --connect-timeout 15 "https://api.github.com/repos/nodejs/node/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "\-" | grep "^refs/tags/v" | grep "^refs/tags/v16" | tail -n 1 | sed "s/refs\/tags\/v//")
    }
    function SelectAdGuardHomePackageVersion() {
        if [ "${ADGUARDHOME_CURRENT}" != "${ADGUARDHOME_LATEST}" ]; then
            ADGUARDHOME_VERSION=${ADGUARDHOME_LATEST}
        else
            ADGUARDHOME_VERSION=${ADGUARDHOME_CURRENT}
        fi
        if [ "${GOLANG_CURRENT}" != "${GOLANG_LATEST}" ]; then
            GOLANG_VERSION=${GOLANG_LATEST}
        else
            GOLANG_VERSION=${GOLANG_CURRENT}
        fi
        if [ "${NODEJS_CURRENT}" != "${NODEJS_LATEST}" ]; then
            NODEJS_VERSION=${NODEJS_LATEST}
        else
            NODEJS_VERSION=${NODEJS_CURRENT}
        fi
    }
    GetAdGuardHomeCurrentPackageVersion && SelectAdGuardHomePackageVersion
}
# Get aria2 Package Version
function Getaria2PackageVersion() {
    function Getaria2CurrentPackageVersion() {
        if [ -f "./package.json" ]; then
            ARIA2_CURRENT=$(cat "./package.json" | jq -Sr ".aria2.version")
            C_ARES_CURRENT=$(cat "./package.json" | jq -Sr ".aria2.lib.version.c_ares")
            EXPAT_CURRENT=$(cat "./package.json" | jq -Sr ".aria2.lib.version.expat")
            GPERFTOOLS_CURRENT=$(cat "./package.json" | jq -Sr ".aria2.lib.version.gperftools")
            LIBSSH2_CURRENT=$(cat "./package.json" | jq -Sr ".aria2.lib.version.libssh2")
            LIBUV_CURRENT=$(cat "./package.json" | jq -Sr ".aria2.lib.version.libuv")
            OPENSSL_CURRENT=$(cat "./package.json" | jq -Sr ".aria2.lib.version.openssl")
            SQLITE_CURRENT=$(cat "./package.json" | jq -Sr ".aria2.lib.version.sqlite")
            ZLIB_NG_CURRENT=$(cat "./package.json" | jq -Sr ".aria2.lib.version.zlib_ng")
        fi
    }
    function Getaria2LatestPackageVersion() {
        ARIA2_LATEST=$(curl -s --connect-timeout 15 "https://api.github.com/repos/aria2/aria2/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/release\-" | tail -n 1 | sed "s/refs\/tags\/release\-//")
        C_ARES_LATEST=$(curl -s --connect-timeout 15 "https://api.github.com/repos/c-ares/c-ares/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/cares\-" | tail -n 1 | sed "s/refs\/tags\/cares\-//" | tr "_" ".")
        EXPAT_LATEST=$(curl -s --connect-timeout 15 "https://api.github.com/repos/libexpat/libexpat/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/R\_" | tail -n 1 | sed "s/refs\/tags\/R\_//" | tr "_" ".")
        GPERFTOOLS_LATEST=$(curl -s --connect-timeout 15 "https://api.github.com/repos/gperftools/gperftools/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/gperftools\-" | tail -n 1 | sed "s/refs\/tags\/gperftools\-//")
        LIBSSH2_LATEST=$(curl -s --connect-timeout 15 "https://api.github.com/repos/libssh2/libssh2/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/libssh2\-" | tail -n 1 | sed "s/refs\/tags\/libssh2\-//")
        LIBUV_LATEST=$(curl -s --connect-timeout 15 "https://api.github.com/repos/libuv/libuv/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/v" | tail -n 1 | sed "s/refs\/tags\/v//")
        OPENSSL_LATEST=$(curl -s --connect-timeout 15 "https://api.github.com/repos/openssl/openssl/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "alpha\|beta" | grep "^refs/tags/openssl\-\|^refs/tags/OpenSSL\_" | grep "^refs/tags/openssl\-3" | tail -n 1 | sed "s/refs\/tags\/openssl\-//;s/refs\/tags\/OpenSSL\_//" | tr "_" ".")
        SQLITE_LATEST=$(curl -s "https://api.github.com/repos/sqlite/sqlite/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/version\-" | tail -n 1 | sed "s/refs\/tags\/version\-//")
        ZLIB_NG_LATEST=$(curl -s --connect-timeout 15 "https://api.github.com/repos/zlib-ng/zlib-ng/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/[0-9]" | tail -n 1 | sed "s/refs\/tags\///")
    }
    function Selectaria2PackageVersion() {
        if [ "${ARIA2_CURRENT}" != "${ARIA2_LATEST}" ]; then
            ARIA2_VERSION=${ARIA2_LATEST}
        else
            ARIA2_VERSION=${ARIA2_CURRENT}
        fi
        if [ "${C_ARES_CURRENT}" != "${C_ARES_LATEST}" ]; then
            C_ARES_VERSION=${C_ARES_LATEST}
        else
            C_ARES_VERSION=${C_ARES_CURRENT}
        fi
        if [ "${EXPAT_CURRENT}" != "${EXPAT_LATEST}" ]; then
            EXPAT_VERSION=${EXPAT_LATEST}
        else
            EXPAT_VERSION=${EXPAT_CURRENT}
        fi
        if [ "${GPERFTOOLS_CURRENT}" != "${GPERFTOOLS_LATEST}" ]; then
            GPERFTOOLS_VERSION=${GPERFTOOLS_LATEST}
        else
            GPERFTOOLS_VERSION=${GPERFTOOLS_CURRENT}
        fi
        if [ "${LIBSSH2_CURRENT}" != "${LIBSSH2_LATEST}" ]; then
            LIBSSH2_VERSION=${LIBSSH2_LATEST}
        else
            LIBSSH2_VERSION=${LIBSSH2_CURRENT}
        fi
        if [ "${LIBUV_CURRENT}" != "${LIBUV_LATEST}" ]; then
            LIBUV_VERSION=${LIBUV_LATEST}
        else
            LIBUV_VERSION=${LIBUV_CURRENT}
        fi
        if [ "${OPENSSL_CURRENT}" != "${OPENSSL_LATEST}" ]; then
            OPENSSL_VERSION=${OPENSSL_LATEST}
        else
            OPENSSL_VERSION=${OPENSSL_CURRENT}
        fi
        if [ "${SQLITE_CURRENT}" != "${SQLITE_LATEST}" ]; then
            SQLITE_VERSION=${SQLITE_LATEST}
        else
            SQLITE_VERSION=${SQLITE_CURRENT}
            if [ -f "./package.json" ]; then
                SQLITE_YEAR_FIXED=${SQLITE_YEAR_FIXED:-$(cat "./package.json" | jq -Sr ".aria2.lib.source.sqlite" | cut -d "/" -f 4)}
            fi
        fi
        if [ "${ZLIB_NG_CURRENT}" != "${ZLIB_NG_LATEST}" ]; then
            ZLIB_NG_VERSION=${ZLIB_NG_LATEST}
        else
            ZLIB_NG_VERSION=${ZLIB_NG_CURRENT}
        fi
    }
    Getaria2CurrentPackageVersion && Selectaria2PackageVersion
}
# Generate Replacements
function GenerateReplacements() {
    replacement_list=(
        "s/{ADGUARDHOME_VERSION}/${ADGUARDHOME_VERSION_FIXED:-${ADGUARDHOME_VERSION}}/g"
        "s/{ARIA2_VERSION}/${ARIA2_VERSION_FIXED:-${ARIA2_VERSION}}/g"
        "s/{C_ARES_VERSION}/${C_ARES_VERSION_FIXED:-${C_ARES_VERSION}}/g"
        "s/{EXPAT_VERSION_}/$(echo ${EXPAT_VERSION_FIXED:-${EXPAT_VERSION}} | tr '.' '_')/g"
        "s/{EXPAT_VERSION}/${EXPAT_VERSION_FIXED:-${EXPAT_VERSION}}/g"
        "s/{GOLANG_VERSION}/${GOLANG_VERSION_FIXED:-${GOLANG_VERSION}}/g"
        "s/{GPERFTOOLS_VERSION}/${GPERFTOOLS_VERSION_FIXED:-${GPERFTOOLS_VERSION}}/g"
        "s/{LIBSSH2_VERSION}/${LIBSSH2_VERSION_FIXED:-${LIBSSH2_VERSION}}/g"
        "s/{LIBUV_VERSION}/${LIBUV_VERSION_FIXED:-${LIBUV_VERSION}}/g"
        "s/{NODEJS_VERSION}/${NODEJS_VERSION_FIXED:-${NODEJS_VERSION}}/g"
        "s/{OPENSSL_VERSION}/${OPENSSL_VERSION_FIXED:-${OPENSSL_VERSION}}/g"
        "s/{SQLITE_VERSION_}/$(echo ${SQLITE_VERSION_FIXED:-${SQLITE_VERSION}} | cut -d '.' -f 1)$(echo ${SQLITE_VERSION_FIXED:-${SQLITE_VERSION}} | cut -d '.' -f 2)0$(echo ${SQLITE_VERSION_FIXED:-${SQLITE_VERSION}} | cut -d '.' -f 3)00/g"
        "s/{SQLITE_VERSION}/${SQLITE_VERSION_FIXED:-${SQLITE_VERSION}}/g"
        "s/{SQLITE_YEAR}/${SQLITE_YEAR_FIXED:-$(date '+%Y')}/g"
        "s/{ZLIB_NG_VERSION}/${ZLIB_NG_VERSION_FIXED:-${ZLIB_NG_VERSION}}/g"
    )
    SED_REPLACEMENT="" && for replacement_list_task in "${!replacement_list[@]}"; do
        SED_REPLACEMENT="${SED_REPLACEMENT}${replacement_list[$replacement_list_task]};"
    done && curl -s --connect-timeout 15 "https://raw.githubusercontent.com/hezhijie0327/Patch/main/template.json" | sed "${SED_REPLACEMENT}" > "./package.json" && cat "./package.json"
}

## Process
# Call GetAdGuardHomePackageVersion
GetAdGuardHomePackageVersion
# Call Getaria2PackageVersion
Getaria2PackageVersion
# Call GenerateReplacements
GenerateReplacements
