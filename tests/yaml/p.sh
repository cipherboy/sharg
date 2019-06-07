#!/bin/bash

cmd=""
remainder=()

function _handle_parse_error() {
    _p_print_help

    if [ "x$1" == "xcmd" ] && [ "x$2" == "xhelp" ]; then
        exit 0
    fi

    echo "Parse error: $1 $2"
    exit 1
}

function _handle_dispatch_error() {
    _p_print_help

    echo "Dispatch error: $1"
    exit 1
}

function ___p_cat() { echo ___p_cat "$@" ; }
function ___p_cd() { echo ___p_cd "$@" ; }
function ___p_clone() { echo ___p_clone "$@" ; }
function ___p_cp() { echo ___p_cp "$@" ; }
function ___p_create() { echo ___p_create "$@" ; }
function ___p_decrypt() { echo ___p_decrypt "$@" ; }
function ___p_edit() { echo ___p_edit "$@" ; }
function ___p_encrypt() { echo ___p_encrypt "$@" ; }
function ___p_find() { echo ___p_find "$@" ; }
function ___p_generate() { echo ___p_generate "$@" ; }
function ___p_git() { echo ___p_git "$@" ; }
function ___p_help() { echo ___p_help "$@" ; }
function ___p_json() { echo ___p_json "$@" ; }
function ___p_keys() { echo ___p_keys "$@" ; }
function ___p_keys_delete() { echo ___p_keys_delete "$@" ; }
function ___p_keys_dir_add() { echo ___p_keys_dir_add "$@" ; }
function ___p_keys_dir_create() { echo ___p_keys_dir_create "$@" ; }
function ___p_keys_dir_delete() { echo ___p_keys_dir_delete "$@" ; }
function ___p_keys_dir_list() { echo ___p_keys_dir_list "$@" ; }
function ___p_keys_dir_regen() { echo ___p_keys_dir_regen "$@" ; }
function ___p_keys_dir_remove() { echo ___p_keys_dir_remove "$@" ; }
function ___p_keys_export() { echo ___p_keys_export "$@" ; }
function ___p_keys_gpg_generate() { echo ___p_keys_gpg_generate "$@" ; }
function ___p_keys_gpg_import() { echo ___p_keys_gpg_import "$@" ; }
function ___p_keys_gpg_list() { echo ___p_keys_gpg_list "$@" ; }
function ___p_keys_gpg_password() { echo ___p_keys_gpg_password "$@" ; }
function ___p_keys_gpg_trust() { echo ___p_keys_gpg_trust "$@" ; }
function ___p_keys_group_add() { echo ___p_keys_group_add "$@" ; }
function ___p_keys_group_create() { echo ___p_keys_group_create "$@" ; }
function ___p_keys_group_delete() { echo ___p_keys_group_delete "$@" ; }
function ___p_keys_group_list() { echo ___p_keys_group_list "$@" ; }
function ___p_keys_group_remove() { echo ___p_keys_group_remove "$@" ; }
function ___p_keys_import() { echo ___p_keys_import "$@" ; }
function ___p_keys_init() { echo ___p_keys_init "$@" ; }
function ___p_keys_list() { echo ___p_keys_list "$@" ; }
function ___p_keys_regen() { echo ___p_keys_regen "$@" ; }
function ___p_keys_rename() { echo ___p_keys_rename "$@" ; }
function ___p_keys_update() { echo ___p_keys_update "$@" ; }
function ___p_locate() { echo ___p_locate "$@" ; }
function ___p_ls() { echo ___p_ls "$@" ; }
function ___p_mkdir() { echo ___p_mkdir "$@" ; }
function ___p_mv() { echo ___p_mv "$@" ; }
function ___p_open() { echo ___p_open "$@" ; }
function ___p_rm() { echo ___p_rm "$@" ; }
function ___p_search() { echo ___p_search "$@" ; }
function ___p_sync() { echo ___p_sync "$@" ; }
function ___p_through() { echo ___p_through "$@" ; }

source args.sh

_p_parse_args "$@"
ret=$?

if (( ret == 0 )); then
    _p_dispatch_subparser
fi
