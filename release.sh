#!/bin/bash

# Current Version: 1.0.4

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
# Get aria2 Package Version
function Get_aria2_PackageVersion() {
    ARIA2_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/aria2/aria2/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/release\-" | tail -n 1 | sed "s/refs\/tags\/release\-//")
    C_ARES_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/c-ares/c-ares/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/cares\-" | tail -n 1 | sed "s/refs\/tags\/cares\-//" | tr "_" ".")
    EXPAT_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/libexpat/libexpat/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/R\_" | tail -n 1 | sed "s/refs\/tags\/R\_//" | tr "_" ".")
    GPERFTOOLS_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/gperftools/gperftools/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/gperftools\-" | tail -n 1 | sed "s/refs\/tags\/gperftools\-//")
    LIBSSH2_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/libssh2/libssh2/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/libssh2\-" | tail -n 1 | sed "s/refs\/tags\/libssh2\-//")
    LIBUV_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/libuv/libuv/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/v" | tail -n 1 | sed "s/refs\/tags\/v//")
    OPENSSL_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/openssl/openssl/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "alpha\|beta" | grep "^refs/tags/openssl\-\|^refs/tags/OpenSSL\_" | grep "^refs/tags/openssl\-3" | tail -n 1 | sed "s/refs\/tags\/openssl\-//;s/refs\/tags\/OpenSSL\_//" | tr "_" ".")
    SQLITE_VERSION=$(curl -s "https://api.github.com/repos/sqlite/sqlite/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/version\-" | tail -n 1 | sed "s/refs\/tags\/version\-//")
    ZLIB_NG_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/zlib-ng/zlib-ng/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/[0-9]" | tail -n 1 | sed "s/refs\/tags\///")
}
# Get AdGuard Home Package Version
function Get_AdGuardHome_PackageVersion() {
    ADGUARDHOME_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/AdguardTeam/AdGuardHome/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "-" | grep "^refs/tags/v" | tail -n 1 | sed "s/refs\/tags\/v//")
    GOLANG_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/golang/go/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "[a-z]$" | grep "^refs/tags/go" | tail -n 1 | sed "s/refs\/tags\/go//")
    NODEJS_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/nodejs/node/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "\-" | grep "^refs/tags/v" | grep "^refs/tags/v16" | tail -n 1 | sed "s/refs\/tags\/v//")
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
# Call Get_aria2_PackageVersion
Get_aria2_PackageVersion
# Call Get_AdGuardHome_PackageVersion
Get_AdGuardHome_PackageVersion
# Call GenerateReplacements
GenerateReplacements
