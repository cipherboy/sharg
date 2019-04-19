function parse_args() {
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
        else
            remainder+=("$arg")
        fi
    done

    if [ "x$parse_args_print_help" == "xtrue" ]; then
        print_help
        return 1
    fi
    return 0
}
function print_help() {
    cat - << _print_help_EOF
Usage: p
Example: p cat my_secret

Arguments:
  cmd: p command to run.

Options:
  --help, -h: Print this help text.
  --password-store-dir, -P: path to the password storage directory
  --gnupg-home-dir, -G: path to the GnuPG home directory
_print_help_EOF
}
