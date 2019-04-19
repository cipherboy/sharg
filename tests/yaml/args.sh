function _p_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        shift

        if [ "x${arg:0:7}" == "x--help=" ] || [ "x${arg:0:6}" == "x-help=" ]; then
            parse_args_print_help="true"
        elif [ "x$arg" == "x--help" ] || [ "x$arg" == "x-help" ] || [ "x$arg" == "x-h" ]; then
            parse_args_print_help="true"
        elif [ "x${arg:0:21}" == "x--password-store-dir=" ] || [ "x${arg:0:20}" == "x-password-store-dir=" ]; then
            local __tmp_password_store_dir="${arg#*=}"

            if [ ! -d "$__tmp_password_store_dir" ]; then
                _handle_parse_error "password-store-dir" "$__tmp_password_store_dir"
            else
                password_store_dir="$__tmp_password_store_dir"
            fi
        elif [ "x$arg" == "x--password-store-dir" ] || [ "x$arg" == "x-password-store-dir" ] || [ "x$arg" == "x-P" ]; then
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
        elif [ "x$arg" == "x--gnupg-home-dir" ] || [ "x$arg" == "x-gnupg-home-dir" ] || [ "x$arg" == "x-G" ]; then
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
    else
        _handle_dispatch_error "$cmd"
    fi
}
