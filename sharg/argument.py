import sys

from .shell import ShellConditional as SC
from .value import Value


class Argument:
    name = None
    var_name = None
    help_text = None

    position = None
    var_position = None

    value_type = None

    whitelist = []
    aliases = {}

    def __init__(self, name=None, var_position=None, position=None,
                 help_text=None, argument_type=None, whitelist=None):
        self.name = name
        self.var_position = var_position
        self.position = position
        self.help_text = help_text
        self.var_name = name.replace('-', '_')
        self.value_type = argument_type
        self.whitelist = whitelist

    def __groups__(self):
        all_groups = set()
        has_none = False

        for key in self.whitelist:
            group = self.whitelist[key].group
            if group:
                all_groups.add(group)
            else:
                has_none = True

        return sorted(all_groups), has_none

    def __by_group__(self, group):
        all_keys = set()

        for key in self.whitelist:
            subcmd = self.whitelist[key]
            if subcmd.group == group:
                all_keys.add(key)

        return sorted(all_keys)

    def format_help(self, _file=sys.stdout, _indent=0, _increment=2):
        indent = " " * _indent
        indent2 = " " * (_indent+_increment)
        indent3 = " " * (_indent+_increment+_increment)

        print(indent + self.name, end='', file=_file)
        if self.help_text:
            print(": " + self.help_text, end='', file=_file)
        print("", file=_file)

        if self.value_type == Value.Subparser:
            groups, has_none = self.__groups__()

            if groups:
                for group in sorted(groups):
                    print(indent2 + group + ":", file=_file)
                    for key in self.__by_group__(group):
                        print(indent3 + "- " + key + ": " + self.whitelist[key].description, file=_file)
                    print("", file=_file)

                print(indent2 + "Other commands:", file=_file)
                for key in self.__by_group__(None):
                    print(indent3 + "- " + key + ": " + self.whitelist[key].description, file=_file)


    def format_bash(self, code):
        cond = SC.int_var_equals_value(self.var_position, self.position)
        code.begin_if_elif(cond)
        code.increment_var(self.var_position)
        self.value_type.format_bash(code, self.name, self.var_name, '$arg',
                                    do_shift=False, whitelist=self.whitelist)
