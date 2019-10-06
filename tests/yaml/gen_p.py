#!/usr/bin/python3

def print_func(name: str, subcommand: bool):
    name = "___p_" + name
    if subcommand:
        print('function ' + name + '() { echo ' + name + ' "$@" ; ' + name + '_parse_args "$@" ; ret=$? ; if (( ret == 0 )); then ' + name + '_dispatch_subparser; fi ; }')
    else:
        print('function ' + name + '() { echo ' + name + ' "$@" ; ' + name + '_parse_args "$@" ; }')


def main():
    functions = [
        "cat",
        "cd",
        "clone",
        "cp",
        "create",
        "decrypt",
        "edit",
        "encrypt",
        "find",
        "generate",
        "git",
        "help",
        "json",
        "json_get",
        "json_set",
        "json_retype",
        "json_kinit",
        "dirs",
        "dir_add",
        "dir_create",
        "dir_delete",
        "dir_list",
        "dir_regen",
        "dir_remoge",
        "gpg",
        "gpg_generate",
        "gpg_import",
        "gpg_list",
        "gpg_password",
        "gpg_trust",
        "groups",
        "group_add",
        "group_create",
        "group_delete",
        "group_list",
        "group_remove",
        "keys",
        "key_import",
        "key_init",
        "key_list",
        "key_regen",
        "key_rename",
        "key_update",
        "key_export",
        "locate",
        "ls",
        "mkdir",
        "mv",
        "open",
        "rm",
        "search",
        "sync",
        "through"
    ]
    have_subcommand = set([
        "dirs",
        "gpg",
        "groups",
        "keys",
        "json"
    ])
    for name in functions:
        print_func(name, name in have_subcommand)


main()
