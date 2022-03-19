#!/bin/bash

# Current Version: 1.0.0

## How to get and use?
# git clone "https://github.com/hezhijie0327/Patch.git" && bash ./Patch/release.sh

function Get_aria2_PackageVersion() {
    ARIA2_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/aria2/aria2/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/release\-" | tail -n 1 | sed "s/refs\/tags\/release\-//")
    C_ARES_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/c-ares/c-ares/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/cares\-" | tail -n 1 | sed "s/refs\/tags\/cares\-//" | tr "_" ".")
    EXPAT_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/libexpat/libexpat/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/R\_" | tail -n 1 | sed "s/refs\/tags\/R\_//" | tr "_" ".")
    GPERFTOOLS_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/gperftools/gperftools/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/gperftools\-" | tail -n 1 | sed "s/refs\/tags\/gperftools\-//")
    LIBSSH2_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/libssh2/libssh2/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/libssh2\-" | tail -n 1 | sed "s/refs\/tags\/libssh2\-//")
    LIBUV_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/libuv/libuv/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/v" | tail -n 1 | sed "s/refs\/tags\/v//")
    OPENSSL_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/openssl/openssl/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "alpha\|beta" | grep "^refs/tags/openssl\-" | tail -n 1 | sed "s/refs\/tags\/openssl\-//")
    SQLITE_VERSION=$(curl -s "https://api.github.com/repos/sqlite/sqlite/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/version\-" | tail -n 1 | sed "s/refs\/tags\/version\-//")
    ZLIB_NG_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/zlib-ng/zlib-ng/git/matching-refs/tags" | jq -Sr ".[].ref" | grep "^refs/tags/[0-9]" | tail -n 1 | sed "s/refs\/tags\///")
}

function Get_adguardhome_PackageVersion() {
    ADGUARDHOME_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/AdguardTeam/AdGuardHome/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "-" | grep "^refs/tags/v" | tail -n 1 | sed "s/refs\/tags\/v//")
    GOLANG_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/golang/go/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "[a-z]$" | grep "^refs/tags/go" | tail -n 1 | sed "s/refs\/tags\/go//")
    NODEJS_VERSION=$(curl -s --connect-timeout 15 "https://api.github.com/repos/nodejs/node/git/matching-refs/tags" | jq -Sr ".[].ref" | grep -v "\-" | grep "^refs/tags/v16" | tail -n 1 | sed "s/refs\/tags\/v//")
}

function GenerateReplacements() {
    replacement_list=(
        "s/{ADGUARDHOME_VERSION}/${ADGUARDHOME_VERSION}/g"
        "s/{ARIA2_VERSION}/${ARIA2_VERSION}/g"
        "s/{C_ARES_VERSION}/${C_ARES_VERSION}/g"
        "s/{EXPAT_VERSION_}/${EXPAT_VERSION//\./\_}/g"
        "s/{EXPAT_VERSION}/${EXPAT_VERSION}/g"
        "s/{GOLANG_VERSION}/$GOLANG_VERSION/g"
        "s/{GPERFTOOLS_VERSION}/${GPERFTOOLS_VERSION}/g"
        "s/{LIBSSH2_VERSION}/${LIBSSH2_VERSION}/g"
        "s/{LIBUV_VERSION}/${LIBUV_VERSION}/g"
        "s/{NODEJS_VERSION}/$NODEJS_VERSION/g"
        "s/{OPENSSL_VERSION}/${OPENSSL_VERSION}/g"
        "s/{SQLITE_VERSION_}/$(echo ${SQLITE_VERSION} | cut -d '.' -f 1)$(echo ${SQLITE_VERSION} | cut -d '.' -f 2)0$(echo ${SQLITE_VERSION} | cut -d '.' -f 3)00/g"
        "s/{SQLITE_VERSION}/${SQLITE_VERSION}/g"
        "s/{SQLITE_YEAR}/$(date +%Y)/g"
        "s/{ZLIB_NG_VERSION}/${ZLIB_NG_VERSION}/g"
    )
    SED_REPLACEMENT="" && for replacement_list_task in "${!replacement_list[@]}"; do
        SED_REPLACEMENT="${SED_REPLACEMENT}${replacement_list[$replacement_list_task]};"
    done && curl -s --connect-timeout 15 "https://raw.githubusercontent.com/hezhijie0327/Patch/dev/template.json" | sed "${SED_REPLACEMENT}" > "./package.json"
}

Get_aria2_PackageVersion
Get_adguardhome_PackageVersion
GenerateReplacements
