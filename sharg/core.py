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

    def add_option(self, long_name=None, short_name=None, help_text=None):
        assert long_name is None or isinstance(long_name, str)
        assert short_name is None or isinstance(short_name, str)
        assert help_text is None or isinstance(help_text, str)

        if long_name and long_name.startswith("--"):
            long_name = long_name[2:]
        if short_name and short_name.startswith("-"):
            short_name = short_name[1:]

        opt = Option(long_name=long_name, short_name=short_name,
                     help_text=help_text)

        opt.parse_equals_value = self.parse_equals_value
        opt.parse_unix_style = self.parse_unix_style

        self.options.append(opt)

        return opt

    def format_help(self, file=sys.stdout, _indent=0):
        indent = " " * _indent

        print(indent + (self.usage % self.program_name), file=file)
        if self.description:
            print(indent + self.description, file=file)
        if self.example:
            print(indent + "Example: " + self.example, file=file)
        print("", file=file)

        if self.arguments:
            print(indent + "Arguments:", file=file)
            for arg in self.arguments:
                arg.format_help(file=file, _indent=_indent+2)

        if self.options:
            print(indent + "Options:", file=file)
            for option in self.options:
                option.format_help(file=file, _indent=_indent+2)

        if self.epilog:
            print(indent + self.epilog, file=file)

    def format_bash(self, file=sys.stdout, _indent=0):
        pass

    def format_man(self, file=sys.stdout, _indent=0):
        pass


class Argument:
    pass


class Option:
    long_name = None
    short_name = None
    help_text = None

    parse_unix_style = False
    parse_equals_value = True

    aliases = []

    def __init__(self, long_name=None, short_name=None, help_text=None):
        self.long_name = long_name
        self.short_name = short_name
        self.help_text = help_text

    def format_help(self, file=sys.stdout, _indent=0):
        indent = " " * _indent
        indent2 = " " * (_indent+2)

        space = False

        print(indent, end='', file=file)
        if self.long_name:
            print("--" + self.long_name, end='', file=file)
            space = True
        if self.short_name:
            if space:
                print(", ", end='', file=file)
                space = False
            print("-" + self.short_name, end='', file=file)
            space = True
        if self.help_text:
            if space:
                print(": ", end='', file=file)
                space = False
            print(self.help_text, end='', file=file)
            space = True
        print("", file=file)
        if self.aliases:
            joined_aliases = ", ".join(self.aliases)
            print(indent2 + "Aliases: " + joined_aliases, end='', file=file)
