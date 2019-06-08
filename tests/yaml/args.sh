function _p_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif [ "x${arg:0:21}" == "x--password-store-dir=" ] || [ "x${arg:0:20}" == "x-password-store-dir=" ]; then
            local __tmp_password_store_dir="${arg#*=}"

            if [ ! -d "$__tmp_password_store_dir" ]; then
                _handle_parse_error "password-store-dir" "$__tmp_password_store_dir"
            else
                password_store_dir="$__tmp_password_store_dir"
            fi
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--password-store-dir" ] || [ "x$arg" == "x-password-store-dir" ] || [ "x$arg" == "x-P" ]; then
            local __tmp_password_store_dir="$1"
            shift

            if [ ! -d "$__tmp_password_store_dir" ]; then
                _handle_parse_error "password-store-dir" "$__tmp_password_store_dir"
            else
                password_store_dir="$__tmp_password_store_dir"
            fi
        elif [ "x${arg:0:17}" == "x--gnupg-home-dir=" ] || [ "x${arg:0:16}" == "x-gnupg-home-dir=" ]; then
            local __tmp_gnupg_home_dir="${arg#*=}"

            if [ ! -d "$__tmp_gnupg_home_dir" ]; then
                _handle_parse_error "gnupg-home-dir" "$__tmp_gnupg_home_dir"
            else
                gnupg_home_dir="$__tmp_gnupg_home_dir"
            fi
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--gnupg-home-dir" ] || [ "x$arg" == "x-gnupg-home-dir" ] || [ "x$arg" == "x-G" ]; then
            local __tmp_gnupg_home_dir="$1"
            shift

            if [ ! -d "$__tmp_gnupg_home_dir" ]; then
                _handle_parse_error "gnupg-home-dir" "$__tmp_gnupg_home_dir"
            else
                gnupg_home_dir="$__tmp_gnupg_home_dir"
            fi
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            local __tmp_cmd="$arg"

            if [ "x$__tmp_cmd" == "xcat" ] || [ "x$__tmp_cmd" == "xshow" ] || [ "x$__tmp_cmd" == "xc" ]; then
                cmd="cat"
            elif [ "x$__tmp_cmd" == "xcd" ]; then
                cmd="cd"
            elif [ "x$__tmp_cmd" == "xclone" ]; then
                cmd="clone"
            elif [ "x$__tmp_cmd" == "xcp" ] || [ "x$__tmp_cmd" == "xcopy" ]; then
                cmd="cp"
            elif [ "x$__tmp_cmd" == "xcreate" ]; then
                cmd="create"
            elif [ "x$__tmp_cmd" == "xdecrypt" ]; then
                cmd="decrypt"
            elif [ "x$__tmp_cmd" == "xdirs" ] || [ "x$__tmp_cmd" == "xdir" ]; then
                cmd="dirs"
            elif [ "x$__tmp_cmd" == "xedit" ] || [ "x$__tmp_cmd" == "xe" ]; then
                cmd="edit"
            elif [ "x$__tmp_cmd" == "xencrypt" ]; then
                cmd="encrypt"
            elif [ "x$__tmp_cmd" == "xfind" ]; then
                cmd="find"
            elif [ "x$__tmp_cmd" == "xgenerate" ] || [ "x$__tmp_cmd" == "xgen" ]; then
                cmd="generate"
            elif [ "x$__tmp_cmd" == "xgit" ] || [ "x$__tmp_cmd" == "xgt" ]; then
                cmd="git"
            elif [ "x$__tmp_cmd" == "xgpg" ]; then
                cmd="gpg"
            elif [ "x$__tmp_cmd" == "xgroups" ] || [ "x$__tmp_cmd" == "xgroup" ]; then
                cmd="groups"
            elif [ "x$__tmp_cmd" == "xjson" ] || [ "x$__tmp_cmd" == "xj" ]; then
                cmd="json"
            elif [ "x$__tmp_cmd" == "xkeys" ] || [ "x$__tmp_cmd" == "xkey" ]; then
                cmd="keys"
            elif [ "x$__tmp_cmd" == "xlocate" ] || [ "x$__tmp_cmd" == "xlt" ]; then
                cmd="locate"
            elif [ "x$__tmp_cmd" == "xls" ] || [ "x$__tmp_cmd" == "xlist" ]; then
                cmd="ls"
            elif [ "x$__tmp_cmd" == "xmkdir" ] || [ "x$__tmp_cmd" == "xm" ]; then
                cmd="mkdir"
            elif [ "x$__tmp_cmd" == "xmv" ] || [ "x$__tmp_cmd" == "xmove" ]; then
                cmd="mv"
            elif [ "x$__tmp_cmd" == "xopen" ]; then
                cmd="open"
            elif [ "x$__tmp_cmd" == "xpass" ] || [ "x$__tmp_cmd" == "xthrough" ] || [ "x$__tmp_cmd" == "xthru" ] || [ "x$__tmp_cmd" == "xt" ]; then
                cmd="pass"
            elif [ "x$__tmp_cmd" == "xrm" ] || [ "x$__tmp_cmd" == "xremove" ]; then
                cmd="rm"
            elif [ "x$__tmp_cmd" == "xsearch" ]; then
                cmd="search"
            elif [ "x$__tmp_cmd" == "xsync" ]; then
                cmd="sync"
            else
                _handle_parse_error "cmd" "$__tmp_cmd"
            fi
        else
            cmd_args+=("$arg")
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        _p_print_help
        return 1
    fi
    return 0
}
function _p_print_help() {
    cat - << _p_print_help_EOF
Usage: p [options] <cmd> [vars.cmd_args...]
a concise, opinionated interface over pass

Arguments:
  cmd: p command to run
    Basic navigation:
      - cd: change directories
      - cp: copy the contents of one file to another location
      - ls: list files and directories
      - mkdir: make a new directory
      - mv: move a file to another location
      - rm: remove the specified path from the password store

    Managing passwords:
      - cat: show the contents of a file
      - edit: edit the contents of a file
      - generate: generate a new password
      - json: manipulate a JSON-encoded password file

    Search commands:
      - find: list all files in the password store
      - locate: locate files and directories matching a pattern
      - search: search the contents of files for a match

    Setup:
      - clone: create a password store from a git repository
      - create: create a password store from scratch
      - dirs: manage keys associated with directories
      - gpg: manage keys in GnuPG's database
      - groups: manage groups of keys used to encrypt passwords
      - keys: manage keys used to encrypt passwords

    Storing files:
      - decrypt: extract a file in the password store
      - encrypt: store a file into the password store
      - open: run a command to view a file in the password store

    Other commands:
      - git: run git commands in the password store
      - pass: pass a command through to pass (for accessing extensions)
      - sync: sync a remote branch with a remote one

Options:
  --help, -h: Print this help text.
  --password-store-dir, -P: path to the password storage directory
  --gnupg-home-dir, -G: path to the GnuPG home directory
_p_print_help_EOF
}
function _p_dispatch_subparser() {
    if [ "x$cmd" == "xcat" ]; then
        ___p_cat "${cmd_args[@]}"
    elif [ "x$cmd" == "xcd" ]; then
        ___p_cd "${cmd_args[@]}"
    elif [ "x$cmd" == "xclone" ]; then
        ___p_clone "${cmd_args[@]}"
    elif [ "x$cmd" == "xcp" ]; then
        ___p_cp "${cmd_args[@]}"
    elif [ "x$cmd" == "xcreate" ]; then
        ___p_create "${cmd_args[@]}"
    elif [ "x$cmd" == "xdecrypt" ]; then
        ___p_decrypt "${cmd_args[@]}"
    elif [ "x$cmd" == "xdirs" ]; then
        ___p_dirs "${cmd_args[@]}"
    elif [ "x$cmd" == "xedit" ]; then
        ___p_edit "${cmd_args[@]}"
    elif [ "x$cmd" == "xencrypt" ]; then
        ___p_encrypt "${cmd_args[@]}"
    elif [ "x$cmd" == "xfind" ]; then
        ___p_find "${cmd_args[@]}"
    elif [ "x$cmd" == "xgenerate" ]; then
        ___p_generate "${cmd_args[@]}"
    elif [ "x$cmd" == "xgit" ]; then
        ___p_git "${cmd_args[@]}"
    elif [ "x$cmd" == "xgpg" ]; then
        ___p_gpg "${cmd_args[@]}"
    elif [ "x$cmd" == "xgroups" ]; then
        ___p_groups "${cmd_args[@]}"
    elif [ "x$cmd" == "xjson" ]; then
        ___p_json "${cmd_args[@]}"
    elif [ "x$cmd" == "xkeys" ]; then
        ___p_keys "${cmd_args[@]}"
    elif [ "x$cmd" == "xlocate" ]; then
        ___p_locate "${cmd_args[@]}"
    elif [ "x$cmd" == "xls" ]; then
        ___p_ls "${cmd_args[@]}"
    elif [ "x$cmd" == "xmkdir" ]; then
        ___p_mkdir "${cmd_args[@]}"
    elif [ "x$cmd" == "xmv" ]; then
        ___p_mv "${cmd_args[@]}"
    elif [ "x$cmd" == "xopen" ]; then
        ___p_open "${cmd_args[@]}"
    elif [ "x$cmd" == "xpass" ]; then
        ___p_through "${cmd_args[@]}"
    elif [ "x$cmd" == "xrm" ]; then
        ___p_rm "${cmd_args[@]}"
    elif [ "x$cmd" == "xsearch" ]; then
        ___p_search "${cmd_args[@]}"
    elif [ "x$cmd" == "xsync" ]; then
        ___p_sync "${cmd_args[@]}"
    elif [ ! -z "$cmd" ]; then
        _handle_dispatch_error "$cmd"
    else
        _p_print_help
    fi
}
function ___p_clone_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            uri="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_clone_print_help
        return 1
    fi
    return 0
}
function ___p_clone_print_help() {
    cat - << ___p_clone_print_help_EOF
Usage: p clone [options] <uri>
create a password store from a git repository

Arguments:
  uri: URI that the git repository resides at

Options:
  --help, -h: Print this help text.
___p_clone_print_help_EOF
}
function ___p_create_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif [ "x${arg:0:14}" == "x--without-git=" ] || [ "x${arg:0:13}" == "x-without-git=" ]; then
            without_git="false"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--without-git" ] || [ "x$arg" == "x-without-git" ] || [ "x$arg" == "x-n" ]; then
            without_git="false"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_id="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_create_print_help
        return 1
    fi
    return 0
}
function ___p_create_print_help() {
    cat - << ___p_create_print_help_EOF
Usage: p create [options] <gpg_id>
create a password store from scratch

Arguments:
  gpg_id: GPG Key ID to initialize password store with

Options:
  --help, -h: Print this help text.
  --without-git, -n: don't create the password store with git
___p_create_print_help_EOF
}
function ___p_keys_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            local __tmp_key_cmd="$arg"

            if [ "x$__tmp_key_cmd" == "xdelete" ]; then
                key_cmd="delete"
            elif [ "x$__tmp_key_cmd" == "xexport" ]; then
                key_cmd="export"
            elif [ "x$__tmp_key_cmd" == "ximport" ]; then
                key_cmd="import"
            elif [ "x$__tmp_key_cmd" == "xinit" ]; then
                key_cmd="init"
            elif [ "x$__tmp_key_cmd" == "xlist" ]; then
                key_cmd="list"
            elif [ "x$__tmp_key_cmd" == "xregen" ]; then
                key_cmd="regen"
            elif [ "x$__tmp_key_cmd" == "xrename" ]; then
                key_cmd="rename"
            elif [ "x$__tmp_key_cmd" == "xupdate" ]; then
                key_cmd="update"
            else
                _handle_parse_error "key_cmd" "$__tmp_key_cmd"
            fi
        else
            key_cmd_args+=("$arg")
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_keys_print_help
        return 1
    fi
    return 0
}
function ___p_keys_print_help() {
    cat - << ___p_keys_print_help_EOF
Usage: p keys [options] <key_cmd> [vars.key_cmd_args...]
manage keys used to encrypt passwords

Arguments:
  key_cmd: key management action
    - init: initialize the key manager
    - import: import a key from gpg's database
    - export: export a key into GnuPG's database and sign it
    - list: list all keys in the key manager
    - regen: recreate all .gpg-id files and re-encrypt passwords
    - delete: delete a key from the key manager
    - rename: change the nickname of a key
    - update: update a key in the database

Options:
  --help, -h: Print this help text.
___p_keys_print_help_EOF
}
function ___p_keys_dispatch_subparser() {
    if [ "x$key_cmd" == "xdelete" ]; then
        ___p_key_delete "${key_cmd_args[@]}"
    elif [ "x$key_cmd" == "xexport" ]; then
        ___p_key_export "${key_cmd_args[@]}"
    elif [ "x$key_cmd" == "ximport" ]; then
        ___p_key_import "${key_cmd_args[@]}"
    elif [ "x$key_cmd" == "xinit" ]; then
        ___p_key_init "${key_cmd_args[@]}"
    elif [ "x$key_cmd" == "xlist" ]; then
        ___p_keys_list "${key_cmd_args[@]}"
    elif [ "x$key_cmd" == "xregen" ]; then
        ___p_keys_regen "${key_cmd_args[@]}"
    elif [ "x$key_cmd" == "xrename" ]; then
        ___p_key_rename "${key_cmd_args[@]}"
    elif [ "x$key_cmd" == "xupdate" ]; then
        ___p_key_update "${key_cmd_args[@]}"
    elif [ ! -z "$key_cmd" ]; then
        _handle_dispatch_error "$key_cmd"
    else
        ___p_keys_print_help
    fi
}
function ___p_key_init_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_id="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_key_init_print_help
        return 1
    fi
    return 0
}
function ___p_key_init_print_help() {
    cat - << ___p_key_init_print_help_EOF
Usage: p keys init [options] <key_id>
initialize the key manager

Arguments:
  key_id: default key to use for key management

Options:
  --help, -h: Print this help text.
___p_key_init_print_help_EOF
}
function ___p_key_import_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_nickname="$arg"
        elif (( $_parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_id="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_key_import_print_help
        return 1
    fi
    return 0
}
function ___p_key_import_print_help() {
    cat - << ___p_key_import_print_help_EOF
Usage: p keys import [options] <key_nickname> <key_id>
import a key from gpg's database

Arguments:
  key_nickname: nickname of the key to import
  key_id: GPG Key ID to import

Options:
  --help, -h: Print this help text.
___p_key_import_print_help_EOF
}
function ___p_key_export_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_nickname="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_key_export_print_help
        return 1
    fi
    return 0
}
function ___p_key_export_print_help() {
    cat - << ___p_key_export_print_help_EOF
Usage: p keys export [options] <key_nickname>
export a key into GnuPG's database and sign it

Arguments:
  key_nickname: nickname of the key to export

Options:
  --help, -h: Print this help text.
___p_key_export_print_help_EOF
}
function ___p_keys_list_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_keys_list_print_help
        return 1
    fi
    return 0
}
function ___p_keys_list_print_help() {
    cat - << ___p_keys_list_print_help_EOF
Usage: p keys list
list all keys in the key manager

Options:
  --help, -h: Print this help text.
___p_keys_list_print_help_EOF
}
function ___p_keys_regen_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_keys_regen_print_help
        return 1
    fi
    return 0
}
function ___p_keys_regen_print_help() {
    cat - << ___p_keys_regen_print_help_EOF
Usage: p keys regen
recreate all .gpg-id files and re-encrypt passwords

Options:
  --help, -h: Print this help text.
___p_keys_regen_print_help_EOF
}
function ___p_key_delete_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_nickname="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_key_delete_print_help
        return 1
    fi
    return 0
}
function ___p_key_delete_print_help() {
    cat - << ___p_key_delete_print_help_EOF
Usage: p keys delete [options] <key_nickname>
delete a key from the key manager

Arguments:
  key_nickname: nickname of the key to delete

Options:
  --help, -h: Print this help text.
___p_key_delete_print_help_EOF
}
function ___p_key_rename_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_old="$arg"
        elif (( $_parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_new="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_key_rename_print_help
        return 1
    fi
    return 0
}
function ___p_key_rename_print_help() {
    cat - << ___p_key_rename_print_help_EOF
Usage: p keys rename [options] <key_old> <key_new>
change the nickname of a key

Arguments:
  key_old: nickname of the key to rename
  key_new: new name for the key

Options:
  --help, -h: Print this help text.
___p_key_rename_print_help_EOF
}
function ___p_key_update_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_nickname="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_key_update_print_help
        return 1
    fi
    return 0
}
function ___p_key_update_print_help() {
    cat - << ___p_key_update_print_help_EOF
Usage: p keys update [options] <key_nickname>
update a key in the database

Arguments:
  key_nickname: nickname of the key to update

Options:
  --help, -h: Print this help text.
___p_key_update_print_help_EOF
}
function ___p_groups_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            local __tmp_group_cmd="$arg"

            if [ "x$__tmp_group_cmd" == "xadd" ]; then
                group_cmd="add"
            elif [ "x$__tmp_group_cmd" == "xcreate" ]; then
                group_cmd="create"
            elif [ "x$__tmp_group_cmd" == "xdelete" ]; then
                group_cmd="delete"
            elif [ "x$__tmp_group_cmd" == "xlist" ]; then
                group_cmd="list"
            elif [ "x$__tmp_group_cmd" == "xremove" ]; then
                group_cmd="remove"
            else
                _handle_parse_error "group_cmd" "$__tmp_group_cmd"
            fi
        else
            group_cmd_args+=("$arg")
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_groups_print_help
        return 1
    fi
    return 0
}
function ___p_groups_print_help() {
    cat - << ___p_groups_print_help_EOF
Usage: p groups [options] <group_cmd> [vars.group_cmd_args...]
manage groups of keys used to encrypt passwords

Arguments:
  group_cmd: group management action
    - create: create a new group
    - add: add keys to a group
    - remove: remove keys from a group
    - delete: delete a group
    - list: list all groups

Options:
  --help, -h: Print this help text.
___p_groups_print_help_EOF
}
function ___p_groups_dispatch_subparser() {
    if [ "x$group_cmd" == "xadd" ]; then
        ___p_group_add "${group_cmd_args[@]}"
    elif [ "x$group_cmd" == "xcreate" ]; then
        ___p_group_create "${group_cmd_args[@]}"
    elif [ "x$group_cmd" == "xdelete" ]; then
        ___p_group_delete "${group_cmd_args[@]}"
    elif [ "x$group_cmd" == "xlist" ]; then
        ___p_group_list "${group_cmd_args[@]}"
    elif [ "x$group_cmd" == "xremove" ]; then
        ___p_group_remove "${group_cmd_args[@]}"
    elif [ ! -z "$group_cmd" ]; then
        _handle_dispatch_error "$group_cmd"
    else
        ___p_groups_print_help
    fi
}
function ___p_group_create_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            group_name="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_group_create_print_help
        return 1
    fi
    return 0
}
function ___p_group_create_print_help() {
    cat - << ___p_group_create_print_help_EOF
Usage: p groups create [options] <group_name> <group_keys...>
create a new group

Arguments:
  group_name: nickname of the group to create
  group_keys: nickname of the keys to add to the group

Options:
  --help, -h: Print this help text.
___p_group_create_print_help_EOF
}
function ___p_group_add_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            group_name="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_group_add_print_help
        return 1
    fi
    return 0
}
function ___p_group_add_print_help() {
    cat - << ___p_group_add_print_help_EOF
Usage: p groups add [options] <group_name> <group_keys...>
add keys to a group

Arguments:
  group_name: group to extend with new keys
  group_keys: nickname of the keys to add to the group

Options:
  --help, -h: Print this help text.
___p_group_add_print_help_EOF
}
function ___p_group_remove_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            group_name="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_group_remove_print_help
        return 1
    fi
    return 0
}
function ___p_group_remove_print_help() {
    cat - << ___p_group_remove_print_help_EOF
Usage: p groups remove [options] <group_name> <group_keys...>
remove keys from a group

Arguments:
  group_name: group to remove keys from
  group_keys: nickname of the keys to remove from the group

Options:
  --help, -h: Print this help text.
___p_group_remove_print_help_EOF
}
function ___p_group_delete_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            group_name="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_group_delete_print_help
        return 1
    fi
    return 0
}
function ___p_group_delete_print_help() {
    cat - << ___p_group_delete_print_help_EOF
Usage: p groups delete [options] <group_name>
delete a group

Arguments:
  group_name: group to extend with new keys

Options:
  --help, -h: Print this help text.
___p_group_delete_print_help_EOF
}
function ___p_group_list_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_group_list_print_help
        return 1
    fi
    return 0
}
function ___p_group_list_print_help() {
    cat - << ___p_group_list_print_help_EOF
Usage: p groups list
list all groups

Options:
  --help, -h: Print this help text.
___p_group_list_print_help_EOF
}
function ___p_dirs_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            local __tmp_dir_cmd="$arg"

            if [ "x$__tmp_dir_cmd" == "xadd" ]; then
                dir_cmd="add"
            elif [ "x$__tmp_dir_cmd" == "xcreate" ]; then
                dir_cmd="create"
            elif [ "x$__tmp_dir_cmd" == "xdelete" ]; then
                dir_cmd="delete"
            elif [ "x$__tmp_dir_cmd" == "xlist" ]; then
                dir_cmd="list"
            elif [ "x$__tmp_dir_cmd" == "xremove" ]; then
                dir_cmd="remove"
            else
                _handle_parse_error "dir_cmd" "$__tmp_dir_cmd"
            fi
        else
            dir_cmd_args+=("$arg")
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_dirs_print_help
        return 1
    fi
    return 0
}
function ___p_dirs_print_help() {
    cat - << ___p_dirs_print_help_EOF
Usage: p dirs [options] <dir_cmd> [vars.dir_cmd_args...]
manage keys associated with directories

Arguments:
  dir_cmd: directory management action
    - create: track a new directory
    - add: add keys to a directory
    - remove: remove keys from a directory
    - delete: delete keys for a directory
    - list: list all directories

Options:
  --help, -h: Print this help text.
___p_dirs_print_help_EOF
}
function ___p_dirs_dispatch_subparser() {
    if [ "x$dir_cmd" == "xadd" ]; then
        ___p_dir_add "${dir_cmd_args[@]}"
    elif [ "x$dir_cmd" == "xcreate" ]; then
        ___p_dir_create "${dir_cmd_args[@]}"
    elif [ "x$dir_cmd" == "xdelete" ]; then
        ___p_dir_delete "${dir_cmd_args[@]}"
    elif [ "x$dir_cmd" == "xlist" ]; then
        ___p_dir_list "${dir_cmd_args[@]}"
    elif [ "x$dir_cmd" == "xremove" ]; then
        ___p_dir_remove "${dir_cmd_args[@]}"
    elif [ ! -z "$dir_cmd" ]; then
        _handle_dispatch_error "$dir_cmd"
    else
        ___p_dirs_print_help
    fi
}
function ___p_dir_create_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            dir_path="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_dir_create_print_help
        return 1
    fi
    return 0
}
function ___p_dir_create_print_help() {
    cat - << ___p_dir_create_print_help_EOF
Usage: p dirs create [options] <dir_path> <dir_keys...>
track a new directory

Arguments:
  dir_path: path of the directory to manage
  dir_keys: nickname of the keys or groups to encrypt the directory with

Options:
  --help, -h: Print this help text.
___p_dir_create_print_help_EOF
}
function ___p_dir_add_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            dir_path="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_dir_add_print_help
        return 1
    fi
    return 0
}
function ___p_dir_add_print_help() {
    cat - << ___p_dir_add_print_help_EOF
Usage: p dirs add [options] <dir_path> <dir_keys...>
add keys to a directory

Arguments:
  dir_path: directory to extend with new keys
  dir_keys: nickname of the keys to add to the directory

Options:
  --help, -h: Print this help text.
___p_dir_add_print_help_EOF
}
function ___p_dir_remove_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            dir_path="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_dir_remove_print_help
        return 1
    fi
    return 0
}
function ___p_dir_remove_print_help() {
    cat - << ___p_dir_remove_print_help_EOF
Usage: p dirs remove [options] <dir_path> <dir_keys...>
remove keys from a directory

Arguments:
  dir_path: directory to remove keys from
  dir_keys: nickname of the keys to remove from the directory

Options:
  --help, -h: Print this help text.
___p_dir_remove_print_help_EOF
}
function ___p_dir_delete_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            dir_path="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_dir_delete_print_help
        return 1
    fi
    return 0
}
function ___p_dir_delete_print_help() {
    cat - << ___p_dir_delete_print_help_EOF
Usage: p dirs delete [options] <dir_path>
delete keys for a directory

Arguments:
  dir_path: directory to quit tracking keys for

Options:
  --help, -h: Print this help text.
___p_dir_delete_print_help_EOF
}
function ___p_dir_list_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_dir_list_print_help
        return 1
    fi
    return 0
}
function ___p_dir_list_print_help() {
    cat - << ___p_dir_list_print_help_EOF
Usage: p dirs list
list all directories

Options:
  --help, -h: Print this help text.
___p_dir_list_print_help_EOF
}
function ___p_gpg_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            local __tmp_gpg_cmd="$arg"

            if [ "x$__tmp_gpg_cmd" == "xexport" ]; then
                gpg_cmd="export"
            elif [ "x$__tmp_gpg_cmd" == "xgenerate" ]; then
                gpg_cmd="generate"
            elif [ "x$__tmp_gpg_cmd" == "ximport" ]; then
                gpg_cmd="import"
            elif [ "x$__tmp_gpg_cmd" == "xlist" ]; then
                gpg_cmd="list"
            elif [ "x$__tmp_gpg_cmd" == "xpassword" ]; then
                gpg_cmd="password"
            elif [ "x$__tmp_gpg_cmd" == "xtrust" ]; then
                gpg_cmd="trust"
            else
                _handle_parse_error "gpg_cmd" "$__tmp_gpg_cmd"
            fi
        else
            gpg_cmd_args+=("$arg")
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_gpg_print_help
        return 1
    fi
    return 0
}
function ___p_gpg_print_help() {
    cat - << ___p_gpg_print_help_EOF
Usage: p gpg [options] <gpg_cmd> [vars.gpg_cmd_args...]
manage keys in GnuPG's database

Arguments:
  gpg_cmd: gpg management action
    - generate: generae a new GPG key
    - import: import a GPG key from a file
    - export: export a GPG key to a file
    - list: list all keys tracked by GPG
    - password: change the password on a key
    - trust: trust and sign the specified GPG key

Options:
  --help, -h: Print this help text.
___p_gpg_print_help_EOF
}
function ___p_gpg_dispatch_subparser() {
    if [ "x$gpg_cmd" == "xexport" ]; then
        ___p_gpg_export "${gpg_cmd_args[@]}"
    elif [ "x$gpg_cmd" == "xgenerate" ]; then
        ___p_gpg_generate "${gpg_cmd_args[@]}"
    elif [ "x$gpg_cmd" == "ximport" ]; then
        ___p_gpg_import "${gpg_cmd_args[@]}"
    elif [ "x$gpg_cmd" == "xlist" ]; then
        ___p_gpg_list "${gpg_cmd_args[@]}"
    elif [ "x$gpg_cmd" == "xpassword" ]; then
        ___p_gpg_password "${gpg_cmd_args[@]}"
    elif [ "x$gpg_cmd" == "xtrust" ]; then
        ___p_gpg_trust "${gpg_cmd_args[@]}"
    elif [ ! -z "$gpg_cmd" ]; then
        _handle_dispatch_error "$gpg_cmd"
    else
        ___p_gpg_print_help
    fi
}
function ___p_gpg_generate_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_name="$arg"
        elif (( $_parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_email="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_gpg_generate_print_help
        return 1
    fi
    return 0
}
function ___p_gpg_generate_print_help() {
    cat - << ___p_gpg_generate_print_help_EOF
Usage: p gpg generate [options] <gpg_name> <gpg_email>
generae a new GPG key

Arguments:
  gpg_name: name of the GPG key's owner
  gpg_email: email address for the GPG key

Options:
  --help, -h: Print this help text.
___p_gpg_generate_print_help_EOF
}
function ___p_gpg_import_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_path="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_gpg_import_print_help
        return 1
    fi
    return 0
}
function ___p_gpg_import_print_help() {
    cat - << ___p_gpg_import_print_help_EOF
Usage: p gpg import [options] <gpg_path>
import a GPG key from a file

Arguments:
  gpg_path: path to the GPG key to import

Options:
  --help, -h: Print this help text.
___p_gpg_import_print_help_EOF
}
function ___p_gpg_export_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_id="$arg"
        elif (( $_parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_path="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_gpg_export_print_help
        return 1
    fi
    return 0
}
function ___p_gpg_export_print_help() {
    cat - << ___p_gpg_export_print_help_EOF
Usage: p gpg export [options] <gpg_id> <gpg_path>
export a GPG key to a file

Arguments:
  gpg_id: identifier of the key to export
  gpg_path: path to write the key to

Options:
  --help, -h: Print this help text.
___p_gpg_export_print_help_EOF
}
function ___p_gpg_list_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_gpg_list_print_help
        return 1
    fi
    return 0
}
function ___p_gpg_list_print_help() {
    cat - << ___p_gpg_list_print_help_EOF
Usage: p gpg list [options] [arguments.gpg_id]
list all keys tracked by GPG

Arguments:
  gpg_id: optionally list only keys matching id

Options:
  --help, -h: Print this help text.
___p_gpg_list_print_help_EOF
}
function ___p_gpg_password_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_id="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_gpg_password_print_help
        return 1
    fi
    return 0
}
function ___p_gpg_password_print_help() {
    cat - << ___p_gpg_password_print_help_EOF
Usage: p gpg password [options] <gpg_id>
change the password on a key

Arguments:
  gpg_id: unique identifier for the GPG key

Options:
  --help, -h: Print this help text.
___p_gpg_password_print_help_EOF
}
function ___p_gpg_trust_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_id="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_gpg_trust_print_help
        return 1
    fi
    return 0
}
function ___p_gpg_trust_print_help() {
    cat - << ___p_gpg_trust_print_help_EOF
Usage: p gpg trust [options] <gpg_id>
trust and sign the specified GPG key

Arguments:
  gpg_id: unique identifier for the GPG key

Options:
  --help, -h: Print this help text.
___p_gpg_trust_print_help_EOF
}
function ___p_cd_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif [ "x${arg:0:11}" == "x--absolute=" ] || [ "x${arg:0:10}" == "x-absolute=" ]; then
            absolute="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--absolute" ] || [ "x$arg" == "x-absolute" ] || [ "x$arg" == "x-a" ]; then
            absolute="true"
        elif [ "x${arg:0:11}" == "x--relative=" ] || [ "x${arg:0:10}" == "x-relative=" ]; then
            relative="true"
        elif (( $_parse_args_positional_index == 0 )) && [ "x$arg" == "x--relative" ] || [ "x$arg" == "x-relative" ] || [ "x$arg" == "x-r" ]; then
            relative="true"
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            cd_path="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_cd_print_help
        return 1
    fi
    return 0
}
function ___p_cd_print_help() {
    cat - << ___p_cd_print_help_EOF
Usage: p cd [options] <cd_path>
change directories

Arguments:
  cd_path: path to change into; absolute if prefixed with '/' or --absolute is specified, else relative

Options:
  --help, -h: Print this help text.
  --absolute, -a: treat as an absolute path
  --relative, -r: treat as a relative path
___p_cd_print_help_EOF
}
function ___p_cp_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif [ "x${arg:0:8}" == "x--force=" ] || [ "x${arg:0:7}" == "x-force=" ]; then
            force="${arg#*=}"
        elif [ "x$arg" == "x--force" ] || [ "x$arg" == "x-force" ] || [ "x$arg" == "x-f" ]; then
            force="$1"
            shift
        elif (( $_parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            old_path="$arg"
        elif (( $_parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            new_path="$arg"
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_cp_print_help
        return 1
    fi
    return 0
}
function ___p_cp_print_help() {
    cat - << ___p_cp_print_help_EOF
Usage: p cp [options] <old_path> <new_path>
copy the contents of one file to another location

Arguments:
  old_path: existing path to copy from
  new_path: destination path to copy to

Options:
  --help, -h: Print this help text.
  --force, -f: silently overwrites destination if it exists
___p_cp_print_help_EOF
}
function ___p_ls_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif [ "x${arg:0:12}" == "x--directory=" ] || [ "x${arg:0:11}" == "x-directory=" ]; then
            directory="${arg#*=}"
        elif [ "x$arg" == "x--directory" ] || [ "x$arg" == "x-directory" ] || [ "x$arg" == "x-d" ]; then
            directory="$1"
            shift
        elif [ "x${arg:0:6}" == "x--all=" ] || [ "x${arg:0:5}" == "x-all=" ]; then
            all="${arg#*=}"
        elif [ "x$arg" == "x--all" ] || [ "x$arg" == "x-all" ] || [ "x$arg" == "x-a" ]; then
            all="$1"
            shift
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_ls_print_help
        return 1
    fi
    return 0
}
function ___p_ls_print_help() {
    cat - << ___p_ls_print_help_EOF
Usage: p ls [options] <ls_paths...>
list files and directories

Arguments:
  ls_paths: paths to inspect

Options:
  --help, -h: Print this help text.
  --directory, -d: list directories themselves, not their contents
  --all, -a: list contents as they appear in the file system, not hiding extensions
___p_ls_print_help_EOF
}
function ___p_mkdir_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif [ "x${arg:0:12}" == "x--recursive=" ] || [ "x${arg:0:11}" == "x-recursive=" ]; then
            recursive="${arg#*=}"
        elif [ "x$arg" == "x--recursive" ] || [ "x$arg" == "x-recursive" ] || [ "x$arg" == "x-r" ]; then
            recursive="$1"
            shift
        elif [ "x${arg:0:11}" == "x--absolute=" ] || [ "x${arg:0:10}" == "x-absolute=" ]; then
            absolute="${arg#*=}"
        elif [ "x$arg" == "x--absolute" ] || [ "x$arg" == "x-absolute" ] || [ "x$arg" == "x-a" ]; then
            absolute="$1"
            shift
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_mkdir_print_help
        return 1
    fi
    return 0
}
function ___p_mkdir_print_help() {
    cat - << ___p_mkdir_print_help_EOF
Usage: p mkdir [options] <mkdir_paths...>
make a new directory

Arguments:
  mkdir_paths: paths to create as directories

Options:
  --help, -h: Print this help text.
  --recursive, -r: recrusively create the specified path
  --absolute, -a: treat the specified path as an relative to /, even if not prefixed by /
___p_mkdir_print_help_EOF
}
function ___p_mv_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_mv_print_help
        return 1
    fi
    return 0
}
function ___p_mv_print_help() {
    cat - << ___p_mv_print_help_EOF
Usage: p mv
move a file to another location

Options:
  --help, -h: Print this help text.
___p_mv_print_help_EOF
}
function ___p_rm_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_rm_print_help
        return 1
    fi
    return 0
}
function ___p_rm_print_help() {
    cat - << ___p_rm_print_help_EOF
Usage: p rm
remove the specified path from the password store

Options:
  --help, -h: Print this help text.
___p_rm_print_help_EOF
}
function ___p_cat_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_cat_print_help
        return 1
    fi
    return 0
}
function ___p_cat_print_help() {
    cat - << ___p_cat_print_help_EOF
Usage: p cat
show the contents of a file

Options:
  --help, -h: Print this help text.
___p_cat_print_help_EOF
}
function ___p_edit_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_edit_print_help
        return 1
    fi
    return 0
}
function ___p_edit_print_help() {
    cat - << ___p_edit_print_help_EOF
Usage: p edit
edit the contents of a file

Options:
  --help, -h: Print this help text.
___p_edit_print_help_EOF
}
function ___p_generate_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_generate_print_help
        return 1
    fi
    return 0
}
function ___p_generate_print_help() {
    cat - << ___p_generate_print_help_EOF
Usage: p generate
generate a new password

Options:
  --help, -h: Print this help text.
___p_generate_print_help_EOF
}
function ___p_json_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_json_print_help
        return 1
    fi
    return 0
}
function ___p_json_print_help() {
    cat - << ___p_json_print_help_EOF
Usage: p json
manipulate a JSON-encoded password file

Options:
  --help, -h: Print this help text.
___p_json_print_help_EOF
}
function ___p_find_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_find_print_help
        return 1
    fi
    return 0
}
function ___p_find_print_help() {
    cat - << ___p_find_print_help_EOF
Usage: p find
list all files in the password store

Options:
  --help, -h: Print this help text.
___p_find_print_help_EOF
}
function ___p_locate_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_locate_print_help
        return 1
    fi
    return 0
}
function ___p_locate_print_help() {
    cat - << ___p_locate_print_help_EOF
Usage: p locate
locate files and directories matching a pattern

Options:
  --help, -h: Print this help text.
___p_locate_print_help_EOF
}
function ___p_search_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_search_print_help
        return 1
    fi
    return 0
}
function ___p_search_print_help() {
    cat - << ___p_search_print_help_EOF
Usage: p search
search the contents of files for a match

Options:
  --help, -h: Print this help text.
___p_search_print_help_EOF
}
function ___p_decrypt_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_decrypt_print_help
        return 1
    fi
    return 0
}
function ___p_decrypt_print_help() {
    cat - << ___p_decrypt_print_help_EOF
Usage: p decrypt
extract a file in the password store

Options:
  --help, -h: Print this help text.
___p_decrypt_print_help_EOF
}
function ___p_encrypt_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_encrypt_print_help
        return 1
    fi
    return 0
}
function ___p_encrypt_print_help() {
    cat - << ___p_encrypt_print_help_EOF
Usage: p encrypt
store a file into the password store

Options:
  --help, -h: Print this help text.
___p_encrypt_print_help_EOF
}
function ___p_open_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_open_print_help
        return 1
    fi
    return 0
}
function ___p_open_print_help() {
    cat - << ___p_open_print_help_EOF
Usage: p open
run a command to view a file in the password store

Options:
  --help, -h: Print this help text.
___p_open_print_help_EOF
}
function ___p_git_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_git_print_help
        return 1
    fi
    return 0
}
function ___p_git_print_help() {
    cat - << ___p_git_print_help_EOF
Usage: p git
run git commands in the password store

Options:
  --help, -h: Print this help text.
___p_git_print_help_EOF
}
function ___p_through_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_through_print_help
        return 1
    fi
    return 0
}
function ___p_through_print_help() {
    cat - << ___p_through_print_help_EOF
Usage: p pass
pass a command through to pass (for accessing extensions)

Options:
  --help, -h: Print this help text.
___p_through_print_help_EOF
}
function ___p_sync_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        ___p_sync_print_help
        return 1
    fi
    return 0
}
function ___p_sync_print_help() {
    cat - << ___p_sync_print_help_EOF
Usage: p sync
sync a remote branch with a remote one

Options:
  --help, -h: Print this help text.
___p_sync_print_help_EOF
}
