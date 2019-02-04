import sys

from enum import Enum

from .shell import ShellCodeGen as SCG
from .shell import ShellConditional as SC


class UnknownBehavior(Enum):
    IGNORE = 1
    ERROR = 2
    COLLECT = 3


class Value(Enum):
    FalseTrue = 1
    TrueFalse = 2
    Directory = 3
    File = 4
    String = 5
    WhitelistedString = 6
    Substring = 7

    def format_bash(self, code, long_name, var_name, source, do_shift=False):
        if self == Value.FalseTrue:
            code.set_var(var_name, 'true')
        elif self == Value.TrueFalse:
            code.set_var(var_name, 'false')
        elif self == Value.Directory:
            code.define_var("__tmp_" + var_name, source)
            if do_shift:
                code.add_line('shift')
            code.add_line('')

            cond = SC.not_is_dir('$__tmp_' + var_name)
            code.begin_if(cond)
            code.add_line('_handle_parse_error "' + long_name + '" ' +
                          '"$__tmp_' + var_name + '"')
            code.begin_else()
            code.set_var(var_name, "$__tmp_" + var_name)
            code.end_if()
        elif self == Value.File:
            code.define_var("__tmp_" + var_name, source)
            if do_shift:
                code.add_line('shift')
            code.add_line('')

            cond = SC.not_is_file('$__tmp_' + var_name)
            code.begin_if(cond)
            code.add_line('_handle_parse_error "' + long_name + '" ' +
                          '"$__tmp_' + var_name + '"')
            code.begin_else()
            code.set_var(var_name, "$__tmp_" + var_name)
            code.end_if()
        elif self == Value.String:
            code.set_var(var_name, source)
            if do_shift:
                code.add_line('shift')
        elif self == Value.WhitelistedString:
            code.define_var("__tmp_" + var_name, source)
            if do_shift:
                code.add_line('shift')
            code.add_line('')

            cond = '_validate_' + var_name + ' "__tmp_' + var_name + '"'
            code.begin_if(cond)
            code.add_line('_handle_parse_error "' + long_name + '" ' +
                          '"$__tmp_' + var_name + '"')
            code.begin_else()
            code.set_var(var_name, "$__tmp_" + var_name)
            code.end_if()
        else:
            raise Exception("Unknown value: %d" % self.value)


class CommandLine:
    options = []
    arguments = []

    program_name = None
    usage = None
    description = None
    example = None
    epilog = None

    positional_arguments = 0
    catch_remainder = None

    parse_unix_style = True
    parse_equals_value = True

    bash_var_prefix = "_pc_"
    bash_indent_increment = 4

    help_indent_increment = 2

    def __init__(self, prog=None, usage=None, description=None, example=None,
                 epilog=None, equals=None, unix=None, add_help=True):
        assert prog is None or isinstance(prog, str)
        assert usage is None or isinstance(usage, str)
        assert description is None or isinstance(description, str)
        assert example is None or isinstance(example, str)
        assert epilog is None or isinstance(epilog, str)
        assert equals is None or isinstance(equals, bool)
        assert unix is None or isinstance(unix, bool)
        assert isinstance(add_help, bool)

        self.program_name = prog
        self.usage = usage
        self.description = description
        self.example = example
        self.epilog = epilog

        if isinstance(equals, bool):
            self.parse_equals_value = equals
        if isinstance(unix, bool):
            self.parse_unix_style = unix

        help_option = self.add_option(long_name='help',
                                      short_name='h',
                                      help_text='Print this help text.',
                                      option_type=Value.FalseTrue)
        help_option.var_name = 'parse_args_print_help'

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

    def add_argument(self, name, help_text=None):
        assert isinstance(name, str)
        assert help_text is None or isinstance(help_text, str)

        arg = Argument(name=name, position=self.positional_arguments,
                       help_text=help_text)

        self.positional_arguments += 1
        self.arguments.append(arg)

        return arg

    def add_option(self, long_name, short_name=None, help_text=None, option_type=Value.FalseTrue):
        assert isinstance(long_name, str)
        assert short_name is None or isinstance(short_name, str)
        assert help_text is None or isinstance(help_text, str)
        assert isinstance(option_type, Value)

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

        if self.arguments:
            print("", file=_file)
            print(indent + "Arguments:", file=_file)
            for arg in self.arguments:
                arg.format_help(_file=_file, _indent=_indent+_increment, _increment=_increment)

        if self.options:
            print("", file=_file)
            print(indent + "Options:", file=_file)
            for option in self.options:
                option.format_help(_file=_file, _indent=_indent+2)

        if self.epilog:
            print("", file=_file)
            print(indent + self.epilog, file=_file)

    def format_bash(self, _file=sys.stdout, _indent=0, _increment=None):
        code = SCG()
        if _increment is None:
            _increment = self.bash_indent_increment
        code.indent = _indent
        code.increment = _increment

        code.begin_function("parse_args")
        code.define_var('parse_args_print_help', 'false')
        cond = SC.int_var_greater_value('#', 0)
        code.begin_while(cond)
        code.define_var('arg', '$1')
        code.add_line('shift')
        code.add_line('')

        if self.options:
            for option in self.options:
                option.format_bash(code)
            code.end_if()

        if self.arguments:
            for argument in self.arguments:
                argument.format_bash(code)
            code.end_if()

        code.end_while()
        code.add_line('')
        cond = SC.str_var_equals_value('parse_args_print_help', 'true')
        code.begin_if(cond)
        code.add_line('print_help')
        code.end_if()
        code.end_function()

        code.begin_function("print_help")
        code.add_line('cat - << _print_help_EOF')
        self.format_help(_file=code, _indent=0, _increment=None)
        code.add_line('_print_help_EOF', indent=0)
        code.end_function()

        code.to_file(_file=_file)


    def format_man(self, _file=sys.stdout, _indent=0):
        pass


class Argument:
    name = None
    var_name = None
    position = None
    help_text = None

    aliases = {}

    def __init__(self, name=None, position=None, help_text=None):
        self.name = name
        self.position = position
        self.help_text = help_text
        self.var_name = name.replace('-', '_')

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


class Option:
    long_name = None
    var_name = None
    short_name = None
    help_text = None

    value_type = None

    parse_unix_style = False
    parse_equals_value = True

    aliases = {}

    def __init__(self, long_name=None, short_name=None, help_text=None, option_type=None):
        self.long_name = long_name
        self.short_name = short_name
        self.help_text = help_text
        self.value_type = option_type
        self.var_name = long_name.replace('-', '_')

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

    def format_bash(self, code):
        print(self.var_name, file=sys.stderr)
        conditionals = []
        if self.parse_equals_value:
            conditionals.append(SC.substr_var_equals_value('arg', '--' + self.long_name + '='))
            if self.parse_unix_style:
                conditionals.append(SC.substr_var_equals_value('arg', '-' + self.long_name + '='))

            code.begin_if_elif(SC.c_or(*conditionals))
            self.value_type.format_bash(code, self.long_name, self.var_name, '${arg#*=}', do_shift=False)
            conditionals = []

        conditionals.append(SC.str_var_equals_value('arg', '--' + self.long_name))
        if self.parse_unix_style:
            conditionals.append(SC.str_var_equals_value('arg', '-' + self.long_name))
        if self.short_name:
            conditionals.append(SC.str_var_equals_value('arg', '-' + self.short_name))

        code.begin_if_elif(SC.c_or(*conditionals))
        self.value_type.format_bash(code, self.long_name, self.var_name, '$1', do_shift=True)
