import sys

from .shell import ShellConditional as SC


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

    def format_help(self, _file=sys.stdout, _indent=0, _increment=2):
        indent = " " * _indent
        indent2 = " " * (_indent+_increment)

        print(indent + self.name, end='', file=_file)
        if self.help_text:
            print(": " + self.help_text, end='', file=_file)
        print("", file=_file)
        if self.aliases:
            joined_aliases = ", ".join(self.aliases)
            print(indent2 + "Aliases: " + joined_aliases, end='', file=_file)

    def format_bash(self, code):
        cond = SC.int_var_equals_value(self.var_position, self.position)
        code.begin_if_elif(cond)
        code.increment_var(self.var_position)
        self.value_type.format_bash(code, self.name, self.var_name, '$arg',
                                    do_shift=False, whitelist=self.whitelist)
