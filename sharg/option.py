import sys

from .value import Value
from .shell import ShellConditional as SC


class Option:
    long_name = None
    var_name = None
    short_name = None
    help_text = None

    value_type = None

    parse_unix_style = False
    parse_equals_value = True

    aliases = {}
    whitelist = None
    value = None

    def __init__(self, long_name=None, short_name=None, help_text=None,
                 option_type=None, whitelist=None, value=None):
        self.long_name = long_name
        self.short_name = short_name
        self.help_text = help_text
        self.value_type = option_type
        self.var_name = long_name.replace('-', '_')
        self.whitelist = whitelist
        self.value = value

    def format_help(self, _file=sys.stdout, _indent=0):
        indent = " " * _indent
        indent2 = " " * (_indent+2)

        space = False

        print(indent, end='', file=_file)
        if self.long_name:
            print("--" + self.long_name, end='', file=_file)
            space = True
        if self.short_name:
            if space:
                print(", ", end='', file=_file)
                space = False
            print("-" + self.short_name, end='', file=_file)
            space = True
        if self.value_type == Value.Directory:
            print(" <dir>", end='', file=_file)
        elif self.value_type == Value.File:
            print(" <file>", end='', file=_file)
        elif self.value_type == Value.String:
            print(" <str>", end='', file=_file)
        if self.help_text:
            if space:
                print(": ", end='', file=_file)
                space = False
            print(self.help_text, end='', file=_file)
            space = True
        print("", file=_file)
        if self.aliases:
            joined_aliases = ", ".join(self.aliases)
            print(indent2 + "Aliases: " + joined_aliases, end='', file=_file)

    def format_bash(self, code, positional=False, var_position=None, position=None):
        if positional:
            assert var_position is not None
            assert position is not None

        conditionals = []

        exclude_equals = (Value.FalseTrue, Value.TrueFalse, Value.Whitelist, Value.Array)

        if self.parse_equals_value and self.value_type not in exclude_equals:
            conditionals.append(SC.substr_var_equals_value('arg', '--' + self.long_name + '='))
            if self.parse_unix_style:
                conditionals.append(SC.substr_var_equals_value('arg', '-' + self.long_name + '='))

            code.begin_if_elif(SC.c_or(*conditionals))
            self.value_type.format_bash(code, self.long_name, self.var_name,
                                        '${arg#*=}', do_shift=False,
                                        whitelist=self.whitelist,
                                        value=self.value)
            conditionals = []

        conditionals.append(SC.str_var_equals_value('arg', '--' + self.long_name))
        if self.parse_unix_style:
            conditionals.append(SC.str_var_equals_value('arg', '-' + self.long_name))
        if self.short_name:
            conditionals.append(SC.str_var_equals_value('arg', '-' + self.short_name))

        cond = SC.c_or(*conditionals)
        if positional:
            position_cond = SC.int_var_equals_value(var_position, position)
            cond = SC.c_and(position_cond, cond)

        code.begin_if_elif(cond)
        self.value_type.format_bash(code, self.long_name, self.var_name,
                                    '$2', do_shift=True,
                                    whitelist=self.whitelist,
                                    value=self.value)
