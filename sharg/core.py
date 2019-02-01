import sys

from enum import Enum

class UnknownBehavior(Enum):
    IGNORE = 1
    ERROR = 2
    COLLECT = 3

class OptionValue(Enum):
    FalseTrue = 1
    TrueFalse = 2
    Directory = 3
    File = 4
    String = 5
    Integer = 6
    Float = 7
    WhitelistedString = 8
    WhitelistedInteger = 9
    Substring = 10

    def format_bash(self, long_name, var_prefix="_", _file=sys.stdout, _indent=0, _increment=4):
        indent = " " * _indent
        indent2 = " " * (_indent+_increment)

        if self == OptionValue.FalseTrue:
            print(indent + var_prefix + long_name + '="true"')
        elif self == OptionValue.Directory:
            print(indent + var_prefix + long_name + '="$1"')
            print(indent + 'shift')
            print()
            print(indent + 'if [ ! -d "$' + var_prefix + long_name + '" ]; then')
            print(indent2 + '_handle_parse_error "' + long_name + '" "$_' + var_prefix + long_name + '"')
            print(indent + 'fi')

class CommandLine:
    options = []
    arguments = []

    program_name = None
    usage = None
    description = None
    example = None
    epilog = None

    parse_unix_style = False
    parse_equals_value = True

    bash_var_prefix = "_pc_"
    bash_indent_increment = 4

    def __init__(self, prog=None, usage=None, description=None, example=None,
                 epilog=None, equals=None, unix=None):
        assert prog is None or isinstance(prog, str)
        assert usage is None or isinstance(usage, str)
        assert description is None or isinstance(description, str)
        assert example is None or isinstance(example, str)
        assert epilog is None or isinstance(epilog, str)
        assert equals is None or isinstance(equals, bool)
        assert unix is None or isinstance(unix, bool)

        self.program_name = prog
        self.usage = usage
        self.description = description
        self.example = example
        self.epilog = epilog

        if isinstance(equals, bool):
            self.parse_equals_value = equals
        if isinstance(unix, bool):
            self.parse_unix_style = unix

        self.__generate_usage__()

    def __generate_usage__(self):
        if not self.program_name:
            self.program_name = "./prog"

        if not self.usage:
            self.usage = "Usage: %s"

            if self.options:
                self.usage += " [options]"
            if self.arguments:
                self.usage += " [arguments]"

    def add_option(self, long_name, short_name=None, help_text=None, option_type=OptionValue.FalseTrue):
        assert long_name is None or isinstance(long_name, str)
        assert short_name is None or isinstance(short_name, str)
        assert help_text is None or isinstance(help_text, str)
        assert isinstance(option_type, OptionValue)
        assert long_name or short_name

        if long_name and long_name.startswith("--"):
            long_name = long_name[2:]
        if short_name and short_name.startswith("-"):
            short_name = short_name[1:]

        opt = Option(long_name=long_name, short_name=short_name,
                     help_text=help_text, option_type=option_type)

        opt.parse_equals_value = self.parse_equals_value
        opt.parse_unix_style = self.parse_unix_style

        self.options.append(opt)

        return opt

    def format_help(self, _file=sys.stdout, _indent=0, _increment=None):
        if _increment is None:
            _increment = self.help_indent_increment

        indent = " " * _indent

        print(indent + (self.usage % self.program_name), file=_file)
        if self.description:
            print(indent + self.description, file=_file)
        if self.example:
            print(indent + "Example: " + self.example, file=_file)
        print("", file=_file)

        if self.arguments:
            print(indent + "Arguments:", file=_file)
            for arg in self.arguments:
                arg.format_help(_file=_file, _indent=_indent+2)

        if self.options:
            print(indent + "Options:", file=_file)
            for option in self.options:
                option.format_help(_file=_file, _indent=_indent+2)

        if self.epilog:
            print(indent + self.epilog, file=_file)

    def format_bash(self, _file=sys.stdout, _indent=0, _increment=None):
        if _increment is None:
            _increment = self.bash_indent_increment

        indent = " " * _indent
        indent2 = " " * (_indent+_increment)

        print(indent + 'while (( $# > 0 )); do', file=_file)
        print(indent2 + 'local arg="$1"', file=_file)
        print(indent2 + 'shift', file=_file)
        print()

        if self.options:
            options_count = len(self.options)
            for _index in range(0, options_count):
                option = self.options[_index]
                check = "elif"
                tail = None

                if _index == 0:
                    check = "if"
                if _index == options_count-1:
                    tail = "fi"

                option.format_bash(check=check, tail=tail, _file=_file, _indent=_indent+_increment, _increment=_increment)

        print(indent + 'done', file=_file)


    def format_man(self, _file=sys.stdout, _indent=0):
        pass


class Argument:
    pass


class Option:
    long_name = None
    short_name = None
    help_text = None

    value_type = None

    parse_unix_style = False
    parse_equals_value = True

    aliases = []

    def __init__(self, long_name=None, short_name=None, help_text=None, option_type=None):
        self.long_name = long_name
        self.short_name = short_name
        self.help_text = help_text
        self.value_type = option_type

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

    def format_bash(self, check="if", tail="fi", _file=sys.stdout, _indent=0, _increment=4):
        indent = " " * _indent
        indent2 = " " * (_indent+_increment)

        conditionals = []

        if self.long_name:
            conditionals.append('[ "x$arg" == "x--' + self.long_name + '" ]')
            if self.parse_unix_style:
                conditionals.append('[ "x$arg" == "x-' + self.long_name + '" ]')
        if self.short_name:
            conditionals.append('[ "x$arg" == "x-' + self.short_name + '" ]')

        joined_conditionals = " || ".join(conditionals)
        print(indent + check, " " + joined_conditionals + "; then", file=_file)
        self.value_type.format_bash(self.long_name, _file=_file, _indent=_indent+_increment, _increment=_increment)

        if tail:
            print(indent + tail, file=_file)
