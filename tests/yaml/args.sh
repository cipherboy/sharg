function _p_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif { [ "${arg:0:21}" == "--password-store-dir=" ] || [ "${arg:0:20}" == "-password-store-dir=" ]; }; then
            local __tmp_password_store_dir="${arg#*=}"

            if [ ! -d "$__tmp_password_store_dir" ]; then
                _handle_parse_error "password-store-dir" "$__tmp_password_store_dir"
            else
                password_store_dir="$__tmp_password_store_dir"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "password_store_dir=${password_store_dir}" 1>&2
                fi
            fi
        elif { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--password-store-dir" ] || [ "$arg" == "-password-store-dir" ] || [ "$arg" == "-P" ]; }; }; then
            local __tmp_password_store_dir="$2"
            shift

            if [ ! -d "$__tmp_password_store_dir" ]; then
                _handle_parse_error "password-store-dir" "$__tmp_password_store_dir"
            else
                password_store_dir="$__tmp_password_store_dir"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "password_store_dir=${password_store_dir}" 1>&2
                fi
            fi
        elif { [ "${arg:0:17}" == "--gnupg-home-dir=" ] || [ "${arg:0:16}" == "-gnupg-home-dir=" ]; }; then
            local __tmp_gnupg_home_dir="${arg#*=}"

            if [ ! -d "$__tmp_gnupg_home_dir" ]; then
                _handle_parse_error "gnupg-home-dir" "$__tmp_gnupg_home_dir"
            else
                gnupg_home_dir="$__tmp_gnupg_home_dir"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "gnupg_home_dir=${gnupg_home_dir}" 1>&2
                fi
            fi
        elif { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--gnupg-home-dir" ] || [ "$arg" == "-gnupg-home-dir" ] || [ "$arg" == "-G" ]; }; }; then
            local __tmp_gnupg_home_dir="$2"
            shift

            if [ ! -d "$__tmp_gnupg_home_dir" ]; then
                _handle_parse_error "gnupg-home-dir" "$__tmp_gnupg_home_dir"
            else
                gnupg_home_dir="$__tmp_gnupg_home_dir"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "gnupg_home_dir=${gnupg_home_dir}" 1>&2
                fi
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            local __tmp_cmd="$arg"

            if { [ "$__tmp_cmd" == "cat" ] || [ "$__tmp_cmd" == "show" ] || [ "$__tmp_cmd" == "c" ]; }; then
                cmd="cat"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif [ "$__tmp_cmd" == "cd" ]; then
                cmd="cd"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif [ "$__tmp_cmd" == "clone" ]; then
                cmd="clone"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "cp" ] || [ "$__tmp_cmd" == "copy" ]; }; then
                cmd="cp"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif [ "$__tmp_cmd" == "create" ]; then
                cmd="create"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif [ "$__tmp_cmd" == "decrypt" ]; then
                cmd="decrypt"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "dirs" ] || [ "$__tmp_cmd" == "dir" ]; }; then
                cmd="dirs"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "edit" ] || [ "$__tmp_cmd" == "e" ]; }; then
                cmd="edit"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif [ "$__tmp_cmd" == "encrypt" ]; then
                cmd="encrypt"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif [ "$__tmp_cmd" == "find" ]; then
                cmd="find"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "generate" ] || [ "$__tmp_cmd" == "gen" ]; }; then
                cmd="generate"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "git" ] || [ "$__tmp_cmd" == "gt" ]; }; then
                cmd="git"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif [ "$__tmp_cmd" == "gpg" ]; then
                cmd="gpg"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "groups" ] || [ "$__tmp_cmd" == "group" ]; }; then
                cmd="groups"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "json" ] || [ "$__tmp_cmd" == "j" ]; }; then
                cmd="json"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "keys" ] || [ "$__tmp_cmd" == "key" ]; }; then
                cmd="keys"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "locate" ] || [ "$__tmp_cmd" == "lt" ]; }; then
                cmd="locate"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "ls" ] || [ "$__tmp_cmd" == "list" ]; }; then
                cmd="ls"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "mkdir" ] || [ "$__tmp_cmd" == "m" ]; }; then
                cmd="mkdir"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "mv" ] || [ "$__tmp_cmd" == "move" ]; }; then
                cmd="mv"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif [ "$__tmp_cmd" == "open" ]; then
                cmd="open"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "pass" ] || [ "$__tmp_cmd" == "through" ] || [ "$__tmp_cmd" == "thru" ] || [ "$__tmp_cmd" == "t" ]; }; then
                cmd="pass"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "rm" ] || [ "$__tmp_cmd" == "remove" ]; }; then
                cmd="rm"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif { [ "$__tmp_cmd" == "search" ] || [ "$__tmp_cmd" == "grep" ]; }; then
                cmd="search"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            elif [ "$__tmp_cmd" == "sync" ]; then
                cmd="sync"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "cmd=${cmd}" 1>&2
                fi
            else
                _handle_parse_error "cmd" "$__tmp_cmd"
            fi
        else
            cmd_args+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "cmd_args=" 1>&2
                echo -n "${cmd_args[@]}" 1>&2
                echo " | len=${#cmd_args[@]}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
      - cat: show the contents of a password entry
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
      - decrypt: extract (decrypt) a file in the password store
      - encrypt: store a file into the password store
      - open: run a command to view a file in the password store

    Other commands:
      - git: run git commands in the password store
      - pass: pass a command through to pass (for accessing extensions)
      - sync: sync a local branch with a remote one

Options:
  --help, -h: Print this help text.
  --password-store-dir, -P <dir>: path to the password storage directory
  --gnupg-home-dir, -G <dir>: path to the GnuPG home directory
_p_print_help_EOF
}
function _p_dispatch_subparser() {
    if [ "$cmd" == "cat" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: cat | ___p_cat"
        fi
        ___p_cat "${cmd_args[@]}"
    elif [ "$cmd" == "cd" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: cd | ___p_cd"
        fi
        ___p_cd "${cmd_args[@]}"
    elif [ "$cmd" == "clone" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: clone | ___p_clone"
        fi
        ___p_clone "${cmd_args[@]}"
    elif [ "$cmd" == "cp" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: cp | ___p_cp"
        fi
        ___p_cp "${cmd_args[@]}"
    elif [ "$cmd" == "create" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: create | ___p_create"
        fi
        ___p_create "${cmd_args[@]}"
    elif [ "$cmd" == "decrypt" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: decrypt | ___p_decrypt"
        fi
        ___p_decrypt "${cmd_args[@]}"
    elif [ "$cmd" == "dirs" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: dirs | ___p_dirs"
        fi
        ___p_dirs "${cmd_args[@]}"
    elif [ "$cmd" == "edit" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: edit | ___p_edit"
        fi
        ___p_edit "${cmd_args[@]}"
    elif [ "$cmd" == "encrypt" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: encrypt | ___p_encrypt"
        fi
        ___p_encrypt "${cmd_args[@]}"
    elif [ "$cmd" == "find" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: find | ___p_find"
        fi
        ___p_find "${cmd_args[@]}"
    elif [ "$cmd" == "generate" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: generate | ___p_generate"
        fi
        ___p_generate "${cmd_args[@]}"
    elif [ "$cmd" == "git" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: git | ___p_git"
        fi
        ___p_git "${cmd_args[@]}"
    elif [ "$cmd" == "gpg" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: gpg | ___p_gpg"
        fi
        ___p_gpg "${cmd_args[@]}"
    elif [ "$cmd" == "groups" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: groups | ___p_groups"
        fi
        ___p_groups "${cmd_args[@]}"
    elif [ "$cmd" == "json" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: json | ___p_json"
        fi
        ___p_json "${cmd_args[@]}"
    elif [ "$cmd" == "keys" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: keys | ___p_keys"
        fi
        ___p_keys "${cmd_args[@]}"
    elif [ "$cmd" == "locate" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: locate | ___p_locate"
        fi
        ___p_locate "${cmd_args[@]}"
    elif [ "$cmd" == "ls" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: ls | ___p_ls"
        fi
        ___p_ls "${cmd_args[@]}"
    elif [ "$cmd" == "mkdir" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: mkdir | ___p_mkdir"
        fi
        ___p_mkdir "${cmd_args[@]}"
    elif [ "$cmd" == "mv" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: mv | ___p_mv"
        fi
        ___p_mv "${cmd_args[@]}"
    elif [ "$cmd" == "open" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: open | ___p_open"
        fi
        ___p_open "${cmd_args[@]}"
    elif [ "$cmd" == "pass" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: pass | ___p_through"
        fi
        ___p_through "${cmd_args[@]}"
    elif [ "$cmd" == "rm" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: rm | ___p_rm"
        fi
        ___p_rm "${cmd_args[@]}"
    elif [ "$cmd" == "search" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: search | ___p_search"
        fi
        ___p_search "${cmd_args[@]}"
    elif [ "$cmd" == "sync" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: sync | ___p_sync"
        fi
        ___p_sync "${cmd_args[@]}"
    elif [ -n "$cmd" ]; then
        _handle_dispatch_error "$cmd"
    else
        _p_print_help
    fi
}
function ___p_clone_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            uri="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "uri=${uri}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif { [ "$arg" == "--without-git" ] || [ "$arg" == "-without-git" ] || [ "$arg" == "-n" ] || [ "$arg" == "--without-git" ] || [ "$arg" == "-without-git" ] || [ "$arg" == "--no-git" ] || [ "$arg" == "-no-git" ]; }; then
            init_git="false"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "init_git=${init_git}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_id="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "gpg_id=${gpg_id}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    Aliases: without-git, no-git
___p_create_print_help_EOF
}
function ___p_keys_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            local __tmp_key_cmd="$arg"

            if [ "$__tmp_key_cmd" == "delete" ]; then
                key_cmd="delete"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "key_cmd=${key_cmd}" 1>&2
                fi
            elif [ "$__tmp_key_cmd" == "export" ]; then
                key_cmd="export"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "key_cmd=${key_cmd}" 1>&2
                fi
            elif [ "$__tmp_key_cmd" == "import" ]; then
                key_cmd="import"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "key_cmd=${key_cmd}" 1>&2
                fi
            elif [ "$__tmp_key_cmd" == "init" ]; then
                key_cmd="init"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "key_cmd=${key_cmd}" 1>&2
                fi
            elif [ "$__tmp_key_cmd" == "list" ]; then
                key_cmd="list"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "key_cmd=${key_cmd}" 1>&2
                fi
            elif [ "$__tmp_key_cmd" == "regen" ]; then
                key_cmd="regen"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "key_cmd=${key_cmd}" 1>&2
                fi
            elif [ "$__tmp_key_cmd" == "rename" ]; then
                key_cmd="rename"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "key_cmd=${key_cmd}" 1>&2
                fi
            elif [ "$__tmp_key_cmd" == "update" ]; then
                key_cmd="update"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "key_cmd=${key_cmd}" 1>&2
                fi
            else
                _handle_parse_error "key_cmd" "$__tmp_key_cmd"
            fi
        else
            key_cmd_args+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "key_cmd_args=" 1>&2
                echo -n "${key_cmd_args[@]}" 1>&2
                echo " | len=${#key_cmd_args[@]}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    - delete: delete a key from the key manager
    - export: export a key into GnuPG's database and sign it
    - import: import a key from gpg's database
    - init: initialize the key manager
    - list: list all keys in the key manager
    - regen: recreate all .gpg-id files and re-encrypt passwords
    - rename: change the nickname of a key
    - update: update a key in the database

Options:
  --help, -h: Print this help text.
___p_keys_print_help_EOF
}
function ___p_keys_dispatch_subparser() {
    if [ "$key_cmd" == "delete" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: delete | ___p_key_delete"
        fi
        ___p_key_delete "${key_cmd_args[@]}"
    elif [ "$key_cmd" == "export" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: export | ___p_key_export"
        fi
        ___p_key_export "${key_cmd_args[@]}"
    elif [ "$key_cmd" == "import" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: import | ___p_key_import"
        fi
        ___p_key_import "${key_cmd_args[@]}"
    elif [ "$key_cmd" == "init" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: init | ___p_key_init"
        fi
        ___p_key_init "${key_cmd_args[@]}"
    elif [ "$key_cmd" == "list" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: list | ___p_key_list"
        fi
        ___p_key_list "${key_cmd_args[@]}"
    elif [ "$key_cmd" == "regen" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: regen | ___p_key_regen"
        fi
        ___p_key_regen "${key_cmd_args[@]}"
    elif [ "$key_cmd" == "rename" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: rename | ___p_key_rename"
        fi
        ___p_key_rename "${key_cmd_args[@]}"
    elif [ "$key_cmd" == "update" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: update | ___p_key_update"
        fi
        ___p_key_update "${key_cmd_args[@]}"
    elif [ -n "$key_cmd" ]; then
        _handle_dispatch_error "$key_cmd"
    else
        ___p_keys_print_help
    fi
}
function ___p_key_init_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_id="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "key_id=${key_id}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_nickname="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "key_nickname=${key_nickname}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_id="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "key_id=${key_id}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_nickname="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "key_nickname=${key_nickname}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
function ___p_key_list_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"


        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_key_list_print_help
        return 1
    fi
    return 0
}
function ___p_key_list_print_help() {
    cat - << ___p_key_list_print_help_EOF
Usage: p keys list
list all keys in the key manager

Options:
  --help, -h: Print this help text.
___p_key_list_print_help_EOF
}
function ___p_key_regen_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"


        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_key_regen_print_help
        return 1
    fi
    return 0
}
function ___p_key_regen_print_help() {
    cat - << ___p_key_regen_print_help_EOF
Usage: p keys regen
recreate all .gpg-id files and re-encrypt passwords

Options:
  --help, -h: Print this help text.
___p_key_regen_print_help_EOF
}
function ___p_key_delete_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_nickname="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "key_nickname=${key_nickname}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_old="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "key_old=${key_old}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_new="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "key_new=${key_new}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key_nickname="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "key_nickname=${key_nickname}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            local __tmp_group_cmd="$arg"

            if [ "$__tmp_group_cmd" == "add" ]; then
                group_cmd="add"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "group_cmd=${group_cmd}" 1>&2
                fi
            elif [ "$__tmp_group_cmd" == "create" ]; then
                group_cmd="create"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "group_cmd=${group_cmd}" 1>&2
                fi
            elif [ "$__tmp_group_cmd" == "delete" ]; then
                group_cmd="delete"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "group_cmd=${group_cmd}" 1>&2
                fi
            elif [ "$__tmp_group_cmd" == "list" ]; then
                group_cmd="list"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "group_cmd=${group_cmd}" 1>&2
                fi
            elif [ "$__tmp_group_cmd" == "remove" ]; then
                group_cmd="remove"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "group_cmd=${group_cmd}" 1>&2
                fi
            else
                _handle_parse_error "group_cmd" "$__tmp_group_cmd"
            fi
        else
            group_cmd_args+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "group_cmd_args=" 1>&2
                echo -n "${group_cmd_args[@]}" 1>&2
                echo " | len=${#group_cmd_args[@]}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    - add: add keys to a group
    - create: create a new group
    - delete: delete a group
    - list: list all groups
    - remove: remove keys from a group

Options:
  --help, -h: Print this help text.
___p_groups_print_help_EOF
}
function ___p_groups_dispatch_subparser() {
    if [ "$group_cmd" == "add" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: add | ___p_group_add"
        fi
        ___p_group_add "${group_cmd_args[@]}"
    elif [ "$group_cmd" == "create" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: create | ___p_group_create"
        fi
        ___p_group_create "${group_cmd_args[@]}"
    elif [ "$group_cmd" == "delete" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: delete | ___p_group_delete"
        fi
        ___p_group_delete "${group_cmd_args[@]}"
    elif [ "$group_cmd" == "list" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: list | ___p_group_list"
        fi
        ___p_group_list "${group_cmd_args[@]}"
    elif [ "$group_cmd" == "remove" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: remove | ___p_group_remove"
        fi
        ___p_group_remove "${group_cmd_args[@]}"
    elif [ -n "$group_cmd" ]; then
        _handle_dispatch_error "$group_cmd"
    else
        ___p_groups_print_help
    fi
}
function ___p_group_create_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            group_name="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "group_name=${group_name}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            group_keys+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "group_keys=" 1>&2
                echo -n "${group_keys[@]}" 1>&2
                echo " | len=${#group_keys[@]}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#group_keys} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            group_name="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "group_name=${group_name}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            group_keys+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "group_keys=" 1>&2
                echo -n "${group_keys[@]}" 1>&2
                echo " | len=${#group_keys[@]}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#group_keys} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            group_name="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "group_name=${group_name}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            group_keys+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "group_keys=" 1>&2
                echo -n "${group_keys[@]}" 1>&2
                echo " | len=${#group_keys[@]}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#group_keys} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            group_name="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "group_name=${group_name}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
        local do_shift="true"


        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            local __tmp_dir_cmd="$arg"

            if [ "$__tmp_dir_cmd" == "add" ]; then
                dir_cmd="add"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "dir_cmd=${dir_cmd}" 1>&2
                fi
            elif [ "$__tmp_dir_cmd" == "create" ]; then
                dir_cmd="create"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "dir_cmd=${dir_cmd}" 1>&2
                fi
            elif [ "$__tmp_dir_cmd" == "delete" ]; then
                dir_cmd="delete"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "dir_cmd=${dir_cmd}" 1>&2
                fi
            elif [ "$__tmp_dir_cmd" == "list" ]; then
                dir_cmd="list"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "dir_cmd=${dir_cmd}" 1>&2
                fi
            elif [ "$__tmp_dir_cmd" == "remove" ]; then
                dir_cmd="remove"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "dir_cmd=${dir_cmd}" 1>&2
                fi
            else
                _handle_parse_error "dir_cmd" "$__tmp_dir_cmd"
            fi
        else
            dir_cmd_args+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "dir_cmd_args=" 1>&2
                echo -n "${dir_cmd_args[@]}" 1>&2
                echo " | len=${#dir_cmd_args[@]}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    - add: add keys to a directory
    - create: track a new directory
    - delete: delete keys for a directory
    - list: list all directories
    - remove: remove keys from a directory

Options:
  --help, -h: Print this help text.
___p_dirs_print_help_EOF
}
function ___p_dirs_dispatch_subparser() {
    if [ "$dir_cmd" == "add" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: add | ___p_dir_add"
        fi
        ___p_dir_add "${dir_cmd_args[@]}"
    elif [ "$dir_cmd" == "create" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: create | ___p_dir_create"
        fi
        ___p_dir_create "${dir_cmd_args[@]}"
    elif [ "$dir_cmd" == "delete" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: delete | ___p_dir_delete"
        fi
        ___p_dir_delete "${dir_cmd_args[@]}"
    elif [ "$dir_cmd" == "list" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: list | ___p_dir_list"
        fi
        ___p_dir_list "${dir_cmd_args[@]}"
    elif [ "$dir_cmd" == "remove" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: remove | ___p_dir_remove"
        fi
        ___p_dir_remove "${dir_cmd_args[@]}"
    elif [ -n "$dir_cmd" ]; then
        _handle_dispatch_error "$dir_cmd"
    else
        ___p_dirs_print_help
    fi
}
function ___p_dir_create_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            dir_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "dir_path=${dir_path}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            dir_keys+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "dir_keys=" 1>&2
                echo -n "${dir_keys[@]}" 1>&2
                echo " | len=${#dir_keys[@]}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#dir_keys} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            dir_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "dir_path=${dir_path}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            dir_keys+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "dir_keys=" 1>&2
                echo -n "${dir_keys[@]}" 1>&2
                echo " | len=${#dir_keys[@]}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#dir_keys} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            dir_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "dir_path=${dir_path}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            dir_keys+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "dir_keys=" 1>&2
                echo -n "${dir_keys[@]}" 1>&2
                echo " | len=${#dir_keys[@]}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#dir_keys} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            dir_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "dir_path=${dir_path}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
        local do_shift="true"


        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            local __tmp_gpg_cmd="$arg"

            if [ "$__tmp_gpg_cmd" == "export" ]; then
                gpg_cmd="export"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "gpg_cmd=${gpg_cmd}" 1>&2
                fi
            elif [ "$__tmp_gpg_cmd" == "generate" ]; then
                gpg_cmd="generate"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "gpg_cmd=${gpg_cmd}" 1>&2
                fi
            elif [ "$__tmp_gpg_cmd" == "import" ]; then
                gpg_cmd="import"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "gpg_cmd=${gpg_cmd}" 1>&2
                fi
            elif [ "$__tmp_gpg_cmd" == "list" ]; then
                gpg_cmd="list"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "gpg_cmd=${gpg_cmd}" 1>&2
                fi
            elif [ "$__tmp_gpg_cmd" == "password" ]; then
                gpg_cmd="password"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "gpg_cmd=${gpg_cmd}" 1>&2
                fi
            elif [ "$__tmp_gpg_cmd" == "trust" ]; then
                gpg_cmd="trust"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "gpg_cmd=${gpg_cmd}" 1>&2
                fi
            else
                _handle_parse_error "gpg_cmd" "$__tmp_gpg_cmd"
            fi
        else
            gpg_cmd_args+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "gpg_cmd_args=" 1>&2
                echo -n "${gpg_cmd_args[@]}" 1>&2
                echo " | len=${#gpg_cmd_args[@]}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    - export: export a GPG key to a file
    - generate: generae a new GPG key
    - import: import a GPG key from a file
    - list: list all keys tracked by GPG
    - password: change the password on a key
    - trust: trust and sign the specified GPG key

Options:
  --help, -h: Print this help text.
___p_gpg_print_help_EOF
}
function ___p_gpg_dispatch_subparser() {
    if [ "$gpg_cmd" == "export" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: export | ___p_gpg_export"
        fi
        ___p_gpg_export "${gpg_cmd_args[@]}"
    elif [ "$gpg_cmd" == "generate" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: generate | ___p_gpg_generate"
        fi
        ___p_gpg_generate "${gpg_cmd_args[@]}"
    elif [ "$gpg_cmd" == "import" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: import | ___p_gpg_import"
        fi
        ___p_gpg_import "${gpg_cmd_args[@]}"
    elif [ "$gpg_cmd" == "list" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: list | ___p_gpg_list"
        fi
        ___p_gpg_list "${gpg_cmd_args[@]}"
    elif [ "$gpg_cmd" == "password" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: password | ___p_gpg_password"
        fi
        ___p_gpg_password "${gpg_cmd_args[@]}"
    elif [ "$gpg_cmd" == "trust" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: trust | ___p_gpg_trust"
        fi
        ___p_gpg_trust "${gpg_cmd_args[@]}"
    elif [ -n "$gpg_cmd" ]; then
        _handle_dispatch_error "$gpg_cmd"
    else
        ___p_gpg_print_help
    fi
}
function ___p_gpg_generate_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_name="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "gpg_name=${gpg_name}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_email="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "gpg_email=${gpg_email}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "gpg_path=${gpg_path}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_id="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "gpg_id=${gpg_id}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "gpg_path=${gpg_path}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_id="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "gpg_id=${gpg_id}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_id="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "gpg_id=${gpg_id}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            gpg_id="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "gpg_id=${gpg_id}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
        local do_shift="true"

        if { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif { [ "${arg:0:11}" == "--absolute=" ] || [ "${arg:0:10}" == "-absolute=" ]; }; then
            cd_mode="absolute"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "cd_mode=${cd_mode}" 1>&2
            fi
        elif { [ "$arg" == "--absolute" ] || [ "$arg" == "-absolute" ] || [ "$arg" == "-a" ]; }; then
            cd_mode="absolute"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "cd_mode=${cd_mode}" 1>&2
            fi
        elif { [ "${arg:0:11}" == "--relative=" ] || [ "${arg:0:10}" == "-relative=" ]; }; then
            cd_mode="relative"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "cd_mode=${cd_mode}" 1>&2
            fi
        elif { [ "$arg" == "--relative" ] || [ "$arg" == "-relative" ] || [ "$arg" == "-r" ]; }; then
            cd_mode="relative"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "cd_mode=${cd_mode}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            cd_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "cd_path=${cd_path}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_cd_print_help
        return 1
    fi
    return 0
}
function ___p_cd_print_help() {
    cat - << ___p_cd_print_help_EOF
Usage: p cd [options] [arguments.cd_path]
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
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif { [ "$arg" == "--force" ] || [ "$arg" == "-force" ] || [ "$arg" == "-f" ]; }; then
            force="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "force=${force}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            old_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "old_path=${old_path}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            new_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "new_path=${new_path}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif { [ "$arg" == "--directory" ] || [ "$arg" == "-directory" ] || [ "$arg" == "-d" ] || [ "$arg" == "--dir" ] || [ "$arg" == "-dir" ]; }; then
            directory="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "directory=${directory}" 1>&2
            fi
        elif { [ "$arg" == "--all" ] || [ "$arg" == "-all" ] || [ "$arg" == "-a" ]; }; then
            all="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "all=${all}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            ls_paths+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "ls_paths=" 1>&2
                echo -n "${ls_paths[@]}" 1>&2
                echo " | len=${#ls_paths[@]}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#ls_paths} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    Aliases: dir
  --all, -a: list contents as they appear in the file system, not hiding extensions
___p_ls_print_help_EOF
}
function ___p_mkdir_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif { [ "$arg" == "--recursive" ] || [ "$arg" == "-recursive" ] || [ "$arg" == "-r" ]; }; then
            recursive="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "recursive=${recursive}" 1>&2
            fi
        elif { [ "$arg" == "--absolute" ] || [ "$arg" == "-absolute" ] || [ "$arg" == "-a" ]; }; then
            absolute="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "absolute=${absolute}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            mkdir_paths+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "mkdir_paths=" 1>&2
                echo -n "${mkdir_paths[@]}" 1>&2
                echo " | len=${#mkdir_paths[@]}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#mkdir_paths} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
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
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            if (( $# > 2 )); then
                _parse_args_positional_index=$((_parse_args_positional_index + 1))
            fi
            mv_srcs+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "mv_srcs=" 1>&2
                echo -n "${mv_srcs[@]}" 1>&2
                echo " | len=${#mv_srcs[@]}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            mv_dest="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "mv_dest=${mv_dest}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#mv_srcs} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_mv_print_help
        return 1
    fi
    return 0
}
function ___p_mv_print_help() {
    cat - << ___p_mv_print_help_EOF
Usage: p mv [options] <mv_srcs...> <mv_dest>
move a file to another location

Arguments:
  mv_srcs: paths to items to move
  mv_dest: path to new location for the specified objects

Options:
  --help, -h: Print this help text.
___p_mv_print_help_EOF
}
function ___p_rm_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif { [ "$arg" == "--recursive" ] || [ "$arg" == "-recursive" ] || [ "$arg" == "-r" ]; }; then
            recursive="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "recursive=${recursive}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            rm_paths="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "rm_paths=${rm_paths}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_rm_print_help
        return 1
    fi
    return 0
}
function ___p_rm_print_help() {
    cat - << ___p_rm_print_help_EOF
Usage: p rm [options] <rm_paths>
remove the specified path from the password store

Arguments:
  rm_paths: paths to remove

Options:
  --help, -h: Print this help text.
  --recursive, -r: recursively remove the specified paths
___p_rm_print_help_EOF
}
function ___p_cat_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif { [ "$arg" == "--raw" ] || [ "$arg" == "-raw" ] || [ "$arg" == "-r" ]; }; then
            cat_raw="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "cat_raw=${cat_raw}" 1>&2
            fi
        elif { [ "$arg" == "--json-only" ] || [ "$arg" == "-json-only" ] || [ "$arg" == "-j" ] || [ "$arg" == "--json" ] || [ "$arg" == "-json" ]; }; then
            cat_json_only="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "cat_json_only=${cat_json_only}" 1>&2
            fi
        elif { [ "$arg" == "--password-only" ] || [ "$arg" == "-password-only" ] || [ "$arg" == "-p" ] || [ "$arg" == "--password" ] || [ "$arg" == "-password" ]; }; then
            cat_password_only="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "cat_password_only=${cat_password_only}" 1>&2
            fi
        elif { [ "$arg" == "--no-color" ] || [ "$arg" == "-no-color" ] || [ "$arg" == "-n" ]; }; then
            cat_colorize="false"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "cat_colorize=${cat_colorize}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            cat_paths+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "cat_paths=" 1>&2
                echo -n "${cat_paths[@]}" 1>&2
                echo " | len=${#cat_paths[@]}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#cat_paths} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_cat_print_help
        return 1
    fi
    return 0
}
function ___p_cat_print_help() {
    cat - << ___p_cat_print_help_EOF
Usage: p cat [options] <cat_paths...>
show the contents of a password entry

Arguments:
  cat_paths: paths of password entries to display

Options:
  --help, -h: Print this help text.
  --raw, -r: raw, uncolorized, machine-readable output
  --json-only, -j: only output the json portion of these password entries, if present
    Aliases: json
  --password-only, -p: only output the first line of the password entry
    Aliases: password
  --no-color, -n: don't colorize the output
___p_cat_print_help_EOF
}
function ___p_edit_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            edit_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "edit_path=${edit_path}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_edit_print_help
        return 1
    fi
    return 0
}
function ___p_edit_print_help() {
    cat - << ___p_edit_print_help_EOF
Usage: p edit [options] <edit_path>
edit the contents of a file

Arguments:
  edit_path: path to the entry to open in an editor

Options:
  --help, -h: Print this help text.
___p_edit_print_help_EOF
}
function ___p_generate_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif { [ "${arg:0:9}" == "--format=" ] || [ "${arg:0:8}" == "-format=" ]; }; then
            format="${arg#*=}"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "format=${format}" 1>&2
            fi
        elif { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--format" ] || [ "$arg" == "-format" ] || [ "$arg" == "-f" ]; }; }; then
            format="$2"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "format=${format}" 1>&2
            fi
            shift
        elif { [ "${arg:0:9}" == "--random=" ] || [ "${arg:0:8}" == "-random=" ] || [ "${arg:0:7}" == "--rand=" ] || [ "${arg:0:6}" == "-rand=" ]; }; then
            mode="random"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "mode=${mode}" 1>&2
            fi
        elif { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--random" ] || [ "$arg" == "-random" ] || [ "$arg" == "-r" ] || [ "$arg" == "--rand" ] || [ "$arg" == "-rand" ]; }; }; then
            mode="random"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "mode=${mode}" 1>&2
            fi
        elif { [ "${arg:0:9}" == "--phrase=" ] || [ "${arg:0:8}" == "-phrase=" ]; }; then
            mode="phrase"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "mode=${mode}" 1>&2
            fi
        elif { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--phrase" ] || [ "$arg" == "-phrase" ] || [ "$arg" == "-p" ]; }; }; then
            mode="phrase"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "mode=${mode}" 1>&2
            fi
        elif { [ "${arg:0:7}" == "--save=" ] || [ "${arg:0:6}" == "-save=" ]; }; then
            name="${arg#*=}"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "name=${name}" 1>&2
            fi
        elif { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--save" ] || [ "$arg" == "-save" ] || [ "$arg" == "-s" ]; }; }; then
            name="$2"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "name=${name}" 1>&2
            fi
            shift
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_generate_print_help
        return 1
    fi
    return 0
}
function ___p_generate_print_help() {
    cat - << ___p_generate_print_help_EOF
Usage: p generate [options]
generate a new password

Options:
  --help, -h: Print this help text.
  --format, -f <str>: format string for generated password
  --random, -r: generate a 30 alphanumeric character password
    Aliases: rand
  --phrase, -p: generate a 3 word, 12 number phrase password
  --save, -s <str>: save generated password to the specified password entry
___p_generate_print_help_EOF
}
function ___p_json_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            local __tmp_json_cmd="$arg"

            if { [ "$__tmp_json_cmd" == "get" ] || [ "$__tmp_json_cmd" == "g" ]; }; then
                json_cmd="get"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "json_cmd=${json_cmd}" 1>&2
                fi
            elif { [ "$__tmp_json_cmd" == "kinit" ] || [ "$__tmp_json_cmd" == "k" ]; }; then
                json_cmd="kinit"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "json_cmd=${json_cmd}" 1>&2
                fi
            elif { [ "$__tmp_json_cmd" == "retype" ] || [ "$__tmp_json_cmd" == "r" ] || [ "$__tmp_json_cmd" == "type" ] || [ "$__tmp_json_cmd" == "t" ]; }; then
                json_cmd="retype"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "json_cmd=${json_cmd}" 1>&2
                fi
            elif { [ "$__tmp_json_cmd" == "set" ] || [ "$__tmp_json_cmd" == "s" ]; }; then
                json_cmd="set"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "json_cmd=${json_cmd}" 1>&2
                fi
            else
                _handle_parse_error "json_cmd" "$__tmp_json_cmd"
            fi
        else
            json_cmd_args+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "json_cmd_args=" 1>&2
                echo -n "${json_cmd_args[@]}" 1>&2
                echo " | len=${#json_cmd_args[@]}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_json_print_help
        return 1
    fi
    return 0
}
function ___p_json_print_help() {
    cat - << ___p_json_print_help_EOF
Usage: p json [options] <json_cmd> [vars.json_cmd_args...]
manipulate a JSON-encoded password file

Arguments:
  json_cmd: json manipulation action
    - get: get a key's value from a file's JSON data
    - kinit: obtain a Kerberos ticket from information in the specified file's JSON data
    - retype: type the key's value from a file's JSON data
    - set: set a key's value in a file's JSON data

Options:
  --help, -h: Print this help text.
___p_json_print_help_EOF
}
function ___p_json_dispatch_subparser() {
    if [ "$json_cmd" == "get" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: get | ___p_json_get"
        fi
        ___p_json_get "${json_cmd_args[@]}"
    elif [ "$json_cmd" == "kinit" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: kinit | ___p_json_kinit"
        fi
        ___p_json_kinit "${json_cmd_args[@]}"
    elif [ "$json_cmd" == "retype" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: retype | ___p_json_retype"
        fi
        ___p_json_retype "${json_cmd_args[@]}"
    elif [ "$json_cmd" == "set" ]; then
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "Dispatching: set | ___p_json_set"
        fi
        ___p_json_set "${json_cmd_args[@]}"
    elif [ -n "$json_cmd" ]; then
        _handle_dispatch_error "$json_cmd"
    else
        ___p_json_print_help
    fi
}
function ___p_json_get_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    j_key="password"
    if [ -n "$SHARG_VERBOSE" ]; then
        echo "j_key=${j_key}" 1>&2
    fi
    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            j_file="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "j_file=${j_file}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            j_key="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "j_key=${j_key}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_json_get_print_help
        return 1
    fi
    return 0
}
function ___p_json_get_print_help() {
    cat - << ___p_json_get_print_help_EOF
Usage: p json get [options] <file> [arguments.key]
get a key's value from a file's JSON data

Arguments:
  file: file to read
  key: key to read out of the file; defaults to password

Options:
  --help, -h: Print this help text.
___p_json_get_print_help_EOF
}
function ___p_json_set_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            j_file="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "j_file=${j_file}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            if (( $# <= 1 )); then
                do_shift="false"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "do_shift=${do_shift}" 1>&2
                fi
                _parse_args_positional_index=$((_parse_args_positional_index + 1))
            else
                _parse_args_positional_index=$((_parse_args_positional_index + 1))
                j_key="$arg"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "j_key=${j_key}" 1>&2
                fi
            fi
        elif (( _parse_args_positional_index == 2 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            j_value="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "j_value=${j_value}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_json_set_print_help
        return 1
    fi
    return 0
}
function ___p_json_set_print_help() {
    cat - << ___p_json_set_print_help_EOF
Usage: p json set [options] <file> [arguments.key] <value>
set a key's value in a file's JSON data

Arguments:
  file: file to write
  key: key to set in the file
  value: value of the key

Options:
  --help, -h: Print this help text.
___p_json_set_print_help_EOF
}
function ___p_json_retype_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    key="password"
    if [ -n "$SHARG_VERBOSE" ]; then
        echo "key=${key}" 1>&2
    fi
    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            file="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "file=${file}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            key="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "key=${key}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_json_retype_print_help
        return 1
    fi
    return 0
}
function ___p_json_retype_print_help() {
    cat - << ___p_json_retype_print_help_EOF
Usage: p json retype [options] <file> [arguments.key]
type the key's value from a file's JSON data

Arguments:
  file: file to read
  key: key to read out of the file; defaults to password

Options:
  --help, -h: Print this help text.
___p_json_retype_print_help_EOF
}
function ___p_json_kinit_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            file="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "file=${file}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_json_kinit_print_help
        return 1
    fi
    return 0
}
function ___p_json_kinit_print_help() {
    cat - << ___p_json_kinit_print_help_EOF
Usage: p json kinit [options] <file>
obtain a Kerberos ticket from information in the specified file's JSON data

Arguments:
  file: file to read

Options:
  --help, -h: Print this help text.
___p_json_kinit_print_help_EOF
}
function ___p_find_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        find_args+=("$arg")
        if [ -n "$SHARG_VERBOSE" ]; then
            echo -n "find_args=" 1>&2
            echo -n "${find_args[@]}" 1>&2
            echo " | len=${#find_args[@]}" 1>&2
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_find_print_help
        return 1
    fi
    return 0
}
function ___p_find_print_help() {
    cat - << ___p_find_print_help_EOF
Usage: p find [vars.find_args...]
list all files in the password store
___p_find_print_help_EOF
}
function ___p_locate_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            substr+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "substr=" 1>&2
                echo -n "${substr[@]}" 1>&2
                echo " | len=${#substr[@]}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#substr} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_locate_print_help
        return 1
    fi
    return 0
}
function ___p_locate_print_help() {
    cat - << ___p_locate_print_help_EOF
Usage: p locate [options] <substr...>
locate files and directories matching a pattern

Arguments:
  substr: substring to match in the path

Options:
  --help, -h: Print this help text.
___p_locate_print_help_EOF
}
function ___p_search_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            if (( $# <= 1 )); then
                do_shift="false"
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo "do_shift=${do_shift}" 1>&2
                fi
                _parse_args_positional_index=$((_parse_args_positional_index + 1))
            else
                if (( $# <= 2 )); then
                    _parse_args_positional_index=$((_parse_args_positional_index + 1))
                fi
                grep_options+=("$arg")
                if [ -n "$SHARG_VERBOSE" ]; then
                    echo -n "grep_options=" 1>&2
                    echo -n "${grep_options[@]}" 1>&2
                    echo " | len=${#grep_options[@]}" 1>&2
                fi
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            search_regex="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "search_regex=${search_regex}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_search_print_help
        return 1
    fi
    return 0
}
function ___p_search_print_help() {
    cat - << ___p_search_print_help_EOF
Usage: p search [options] [arguments.grep_options...] <search_regex>
search the contents of files for a match

Arguments:
  grep_options: additional arguments to pass to grep
  search_regex: regex to pass to grep

Options:
  --help, -h: Print this help text.
___p_search_print_help_EOF
}
function ___p_decrypt_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            entry="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "entry=${entry}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            result_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "result_path=${result_path}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_decrypt_print_help
        return 1
    fi
    return 0
}
function ___p_decrypt_print_help() {
    cat - << ___p_decrypt_print_help_EOF
Usage: p decrypt [options] <entry> [arguments.result_path]
extract (decrypt) a file in the password store

Arguments:
  entry: vault entry to decrypt
  result_path: filesystem path to store the decrypted file at

Options:
  --help, -h: Print this help text.
___p_decrypt_print_help_EOF
}
function ___p_encrypt_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            file_path="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "file_path=${file_path}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            entry="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "entry=${entry}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( _parse_args_positional_index < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_encrypt_print_help
        return 1
    fi
    return 0
}
function ___p_encrypt_print_help() {
    cat - << ___p_encrypt_print_help_EOF
Usage: p encrypt [options] <file_path> <entry>
store a file into the password store

Arguments:
  file_path: filesystem path to read
  entry: vault entry to encrypt to

Options:
  --help, -h: Print this help text.
___p_encrypt_print_help_EOF
}
function ___p_open_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    if (( $# < 2 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--read-only" ] || [ "$arg" == "-read-only" ] || [ "$arg" == "-r" ]; }; }; then
            read_only="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "read_only=${read_only}" 1>&2
            fi
        elif { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--no-lock" ] || [ "$arg" == "-no-lock" ] || [ "$arg" == "-l" ]; }; }; then
            no_lock="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "no_lock=${no_lock}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            open_entry="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "open_entry=${open_entry}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            open_command+=("$arg")
            if [ -n "$SHARG_VERBOSE" ]; then
                echo -n "open_command=" 1>&2
                echo -n "${open_command[@]}" 1>&2
                echo " | len=${#open_command[@]}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if (( ${#open_command} == 0 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if (( _parse_args_positional_index < 1 )); then
        parse_args_print_help="true"
        if [ -n "$SHARG_VERBOSE" ]; then
            echo "parse_args_print_help=${parse_args_print_help}" 1>&2
        fi
    fi

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_open_print_help
        return 1
    fi
    return 0
}
function ___p_open_print_help() {
    cat - << ___p_open_print_help_EOF
Usage: p open [options] <open_entry> <open_command...>
run a command to view a file in the password store

Arguments:
  open_entry: password entry to open
  open_command: command

Options:
  --help, -h: Print this help text.
  --read-only, -r: do not save changes made to the file
  --no-lock, -l: do not try to acquire a lock before opening the file
___p_open_print_help_EOF
}
function ___p_git_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        git_args+=("$arg")
        if [ -n "$SHARG_VERBOSE" ]; then
            echo -n "git_args=" 1>&2
            echo -n "${git_args[@]}" 1>&2
            echo " | len=${#git_args[@]}" 1>&2
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_git_print_help
        return 1
    fi
    return 0
}
function ___p_git_print_help() {
    cat - << ___p_git_print_help_EOF
Usage: p git [vars.git_args...]
run git commands in the password store
___p_git_print_help_EOF
}
function ___p_through_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        pass_args+=("$arg")
        if [ -n "$SHARG_VERBOSE" ]; then
            echo -n "pass_args=" 1>&2
            echo -n "${pass_args[@]}" 1>&2
            echo " | len=${#pass_args[@]}" 1>&2
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_through_print_help
        return 1
    fi
    return 0
}
function ___p_through_print_help() {
    cat - << ___p_through_print_help_EOF
Usage: p pass [vars.pass_args...]
pass a command through to pass (for accessing extensions)
___p_through_print_help_EOF
}
function ___p_sync_parse_args() {
    local parse_args_print_help="false"
    local _parse_args_positional_index="0"
    origin="origin"
    if [ -n "$SHARG_VERBOSE" ]; then
        echo "origin=${origin}" 1>&2
    fi
    remote="master"
    if [ -n "$SHARG_VERBOSE" ]; then
        echo "remote=${remote}" 1>&2
    fi
    while (( $# > 0 )); do
        local arg="$1"
        local do_shift="true"

        if { (( _parse_args_positional_index == 0 )) && { [ "$arg" == "--help" ] || [ "$arg" == "-help" ] || [ "$arg" == "-h" ]; }; }; then
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        elif (( _parse_args_positional_index == 0 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            branch="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "branch=${branch}" 1>&2
            fi
        elif (( _parse_args_positional_index == 1 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            origin="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "origin=${origin}" 1>&2
            fi
        elif (( _parse_args_positional_index == 2 )); then
            _parse_args_positional_index=$((_parse_args_positional_index + 1))
            remote="$arg"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "remote=${remote}" 1>&2
            fi
        else
            parse_args_print_help="true"
            if [ -n "$SHARG_VERBOSE" ]; then
                echo "parse_args_print_help=${parse_args_print_help}" 1>&2
            fi
        fi

        if [ "$do_shift" == "true" ]; then
            shift
        fi
    done

    if [ "$parse_args_print_help" == "true" ]; then
        ___p_sync_print_help
        return 1
    fi
    return 0
}
function ___p_sync_print_help() {
    cat - << ___p_sync_print_help_EOF
Usage: p sync [options] [arguments.branch] [arguments.origin] [arguments.remote]
sync a local branch with a remote one

Arguments:
  branch: local branch to sync from; defaults to the current branch
  origin: remote origin to sync to; defaults to origin
  remote: remote branch to sync to; defaults to master

Options:
  --help, -h: Print this help text.
___p_sync_print_help_EOF
}
