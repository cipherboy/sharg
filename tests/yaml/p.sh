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

function ___p_cat() { echo ___p_cat "$@" ; ___p_cat_parse_args "$@" ; }
function ___p_cd() { echo ___p_cd "$@" ; ___p_cd_parse_args "$@" ; }
function ___p_clone() { echo ___p_clone "$@" ; ___p_clone_parse_args "$@" ; }
function ___p_cp() { echo ___p_cp "$@" ; ___p_cp_parse_args "$@" ; }
function ___p_create() { echo ___p_create "$@" ; ___p_create_parse_args "$@" ; }
function ___p_decrypt() { echo ___p_decrypt "$@" ; ___p_decrypt_parse_args "$@" ; }
function ___p_encrypt() { echo ___p_encrypt "$@" ; ___p_encrypt_parse_args "$@" ; }
function ___p_find() { echo ___p_find "$@" ; ___p_find_parse_args "$@" ; }
function ___p_generate() { echo ___p_generate "$@" ; ___p_generate_parse_args "$@" ; }
function ___p_git() { echo ___p_git "$@" ; ___p_git_parse_args "$@" ; }
function ___p_help() { echo ___p_help "$@" ; ___p_help_parse_args "$@" ; }
function ___p_json() { echo ___p_json "$@" ; ___p_json_parse_args "$@" ; ret=$? ; if (( ret == 0 )); then ___p_json_dispatch_subparser; fi ; }
function ___p_json_get() { echo ___p_json_get "$@" ; ___p_json_get_parse_args "$@" ; }
function ___p_json_set() { echo ___p_json_set "$@" ; ___p_json_set_parse_args "$@" ; }
function ___p_json_retype() { echo ___p_json_retype "$@" ; ___p_json_retype_parse_args "$@" ; }
function ___p_json_kinit() { echo ___p_json_kinit "$@" ; ___p_json_kinit_parse_args "$@" ; }
function ___p_dirs() { echo ___p_dirs "$@" ; ___p_dirs_parse_args "$@" ; ret=$? ; if (( ret == 0 )); then ___p_dirs_dispatch_subparser; fi ; }
function ___p_dir_add() { echo ___p_dir_add "$@" ; ___p_dir_add_parse_args "$@" ; }
function ___p_dir_create() { echo ___p_dir_create "$@" ; ___p_dir_create_parse_args "$@" ; }
function ___p_dir_delete() { echo ___p_dir_delete "$@" ; ___p_dir_delete_parse_args "$@" ; }
function ___p_dir_list() { echo ___p_dir_list "$@" ; ___p_dir_list_parse_args "$@" ; }
function ___p_dir_regen() { echo ___p_dir_regen "$@" ; ___p_dir_regen_parse_args "$@" ; }
function ___p_dir_remoge() { echo ___p_dir_remoge "$@" ; ___p_dir_remoge_parse_args "$@" ; }
function ___p_gpg() { echo ___p_gpg "$@" ; ___p_gpg_parse_args "$@" ; ret=$? ; if (( ret == 0 )); then ___p_gpg_dispatch_subparser; fi ; }
function ___p_gpg_generate() { echo ___p_gpg_generate "$@" ; ___p_gpg_generate_parse_args "$@" ; }
function ___p_gpg_import() { echo ___p_gpg_import "$@" ; ___p_gpg_import_parse_args "$@" ; }
function ___p_gpg_list() { echo ___p_gpg_list "$@" ; ___p_gpg_list_parse_args "$@" ; }
function ___p_gpg_password() { echo ___p_gpg_password "$@" ; ___p_gpg_password_parse_args "$@" ; }
function ___p_gpg_trust() { echo ___p_gpg_trust "$@" ; ___p_gpg_trust_parse_args "$@" ; }
function ___p_groups() { echo ___p_groups "$@" ; ___p_groups_parse_args "$@" ; ret=$? ; if (( ret == 0 )); then ___p_groups_dispatch_subparser; fi ; }
function ___p_group_add() { echo ___p_group_add "$@" ; ___p_group_add_parse_args "$@" ; }
function ___p_group_create() { echo ___p_group_create "$@" ; ___p_group_create_parse_args "$@" ; }
function ___p_group_delete() { echo ___p_group_delete "$@" ; ___p_group_delete_parse_args "$@" ; }
function ___p_group_list() { echo ___p_group_list "$@" ; ___p_group_list_parse_args "$@" ; }
function ___p_group_remove() { echo ___p_group_remove "$@" ; ___p_group_remove_parse_args "$@" ; }
function ___p_keys() { echo ___p_keys "$@" ; ___p_keys_parse_args "$@" ; ret=$? ; if (( ret == 0 )); then ___p_keys_dispatch_subparser; fi ; }
function ___p_key_import() { echo ___p_key_import "$@" ; ___p_key_import_parse_args "$@" ; }
function ___p_key_init() { echo ___p_key_init "$@" ; ___p_key_init_parse_args "$@" ; }
function ___p_key_list() { echo ___p_key_list "$@" ; ___p_key_list_parse_args "$@" ; }
function ___p_key_regen() { echo ___p_key_regen "$@" ; ___p_key_regen_parse_args "$@" ; }
function ___p_key_rename() { echo ___p_key_rename "$@" ; ___p_key_rename_parse_args "$@" ; }
function ___p_key_update() { echo ___p_key_update "$@" ; ___p_key_update_parse_args "$@" ; }
function ___p_key_export() { echo ___p_key_export "$@" ; ___p_key_export_parse_args "$@" ; }
function ___p_locate() { echo ___p_locate "$@" ; ___p_locate_parse_args "$@" ; }
function ___p_ls() { echo ___p_ls "$@" ; ___p_ls_parse_args "$@" ; }
function ___p_mkdir() { echo ___p_mkdir "$@" ; ___p_mkdir_parse_args "$@" ; }
function ___p_mv() { echo ___p_mv "$@" ; ___p_mv_parse_args "$@" ; }
function ___p_open() { echo ___p_open "$@" ; ___p_open_parse_args "$@" ; }
function ___p_rm() { echo ___p_rm "$@" ; ___p_rm_parse_args "$@" ; }
function ___p_search() { echo ___p_search "$@" ; ___p_search_parse_args "$@" ; }
function ___p_sync() { echo ___p_sync "$@" ; ___p_sync_parse_args "$@" ; }
function ___p_through() { echo ___p_through "$@" ; ___p_through_parse_args "$@" ; }

source args.sh

echo _p "$@"
_p_parse_args "$@"
ret=$?

if (( ret == 0 )); then
    _p_dispatch_subparser
fi
