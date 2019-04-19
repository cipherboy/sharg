password_store_dir="zz"
gnupg_home_dir="zz"
cmd="zz"
remainder=()

function _handle_parse_error() {
    echo "Parse error: $1 $2"
}

source arg_test2.sh

parse_args "$@"

echo "-P: $password_store_dir"
echo "-G: $gnupg_home_dir"
echo "cmd: $cmd"
echo "remainder:" "${remainder[@]}"
