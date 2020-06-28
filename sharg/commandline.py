import sys
from typing import List

from .shell import ShellCodeGen as SCG
from .shell import ShellConditional as SC

from .value import Value
from .argument import Argument
from .option import Option


class CommandLine:
    options: List[Option] = []
    arguments: List[Argument] = []
    grammar: List[str] = []

    program_name: str = ""
    aliases: List[str] = []

    usage = None
    description = None
    group = None
    example = None
    epilog = None

    function_name = None

    positional_arguments = 0
    bash_var_position = "_parse_args_positional_index"

    catch_remainder = False
    bash_var_remainder = "_parse_args_remainder"

    mixed_options_arguments = True

    parse_unix_style = True
    parse_equals_value = True

    bash_var_prefix = "_"
    bash_indent_increment = 4

    help_indent_increment = 2

    pre_parse_hook = None
    pre_dispatch_hook = None

    def __init__(
        self,
        prog="",
        usage=None,
        description=None,
        group=None,
        example=None,
        epilog=None,
        equals=None,
        unix=None,
        add_help=True,
        catch_remainder=False,
        aliases=[],
        grammar=[],
        pre_parse_hook=None,
        pre_dispatch_hook=None,
        function_name=None,
    ):
        assert isinstance(prog, str)
        assert usage is None or isinstance(usage, str)
        assert description is None or isinstance(description, str)
        assert group is None or isinstance(group, str)
        assert example is None or isinstance(example, str)
        assert epilog is None or isinstance(epilog, str)
        assert equals is None or isinstance(equals, bool)
        assert unix is None or isinstance(unix, bool)
        assert isinstance(add_help, bool)
        assert isinstance(catch_remainder, bool)
        assert isinstance(aliases, list)
        assert isinstance(grammar, list)
        assert pre_parse_hook is None or isinstance(pre_parse_hook, str)
        assert pre_dispatch_hook is None or isinstance(pre_dispatch_hook, str)
        assert function_name is None or isinstance(function_name, str)

        self.options = []
        self.arguments = []
        self.grammar = []

        self.program_name = prog
        self.aliases = aliases

        self.usage = usage
        self.description = description
        self.group = group
        self.example = example
        self.epilog = epilog

        if isinstance(equals, bool):
            self.parse_equals_value = equals
        if isinstance(unix, bool):
            self.parse_unix_style = unix

        if add_help:
            help_option = self.add_option(
                long_name="help",
                short_name="h",
                help_text="Print this help text.",
                option_type=Value.FalseTrue,
            )
            help_option.var_name = "parse_args_print_help"

        self.catch_remainder = catch_remainder
        self.grammar = grammar

        self.pre_parse_hook = pre_parse_hook
        self.pre_dispatch_hook = pre_dispatch_hook

        self.function_name = function_name

        self.__generate_usage__()

    def __generate_usage__(self):
        if not self.program_name:
            self.program_name = "./prog"

        if not self.usage:
            self.usage = "Usage: %s"

            # if self.options:
            #    self.usage += " [options]"
            # if self.arguments:
            #    self.usage += " [arguments]"
            for item in self.grammar:
                self.usage += " "
                if item.startswith("arguments."):
                    self.usage += "<" + item[10:] + ">"
                elif item == "...":
                    self.usage += "[...]"
                else:
                    self.usage += item

    def add_argument(
        self,
        name,
        help_text=None,
        argument_type=Value.String,
        whitelist=None,
        value=None,
        default=None,
    ):
        assert isinstance(name, str)
        assert help_text is None or isinstance(help_text, str)
        assert isinstance(argument_type, Value)

        arg = Argument(
            name=name,
            var_position=self.bash_var_position,
            position=self.positional_arguments,
            argument_type=argument_type,
            whitelist=whitelist,
            value=value,
            default=default,
        )

        arg.help_text.short_desc = help_text

        self.positional_arguments += 1
        self.arguments.append(arg)

        return arg

    def add_option(
        self,
        long_name,
        short_name=None,
        help_text=None,
        option_type=Value.FalseTrue,
        value=None,
    ):
        assert isinstance(long_name, str)
        assert short_name is None or isinstance(short_name, str)
        assert help_text is None or isinstance(help_text, str)
        assert isinstance(option_type, Value)

        if long_name and long_name.startswith("--"):
            long_name = long_name[2:]
        if short_name and short_name.startswith("-"):
            short_name = short_name[1:]

        opt = Option(
            long_name=long_name,
            short_name=short_name,
            option_type=option_type,
            value=value,
        )

        opt.help_text.short_desc = help_text

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
                arg.format_help(
                    _file=_file, _indent=_indent + _increment, _increment=_increment
                )

        if self.options:
            print("", file=_file)
            print(indent + "Options:", file=_file)
            for option in self.options:
                option.format_help(_file=_file, _indent=_indent + 2)

        if self.epilog:
            print("", file=_file)
            print(indent + self.epilog, file=_file)

    def find_argument(self, name):
        for argument in self.arguments:
            if argument.name == name:
                return argument

        return None

    def num_remaining(self, index=0):
        count = 0
        for item in self.grammar[index:]:
            if item.startswith("arguments."):
                count += 1
        return count

    def format_bash(self, _code=None, _file=sys.stdout, _indent=0, _increment=None):
        code = _code
        if code is None:
            code = SCG()

        if _increment is None:
            _increment = self.bash_indent_increment
        code.indent = _indent
        code.increment = _increment

        parse_function = "parse_args"
        help_function = "print_help"
        dispatch_function = "dispatch_subparser"
        if self.function_name:
            parse_function = self.function_name + "_" + parse_function
            help_function = self.function_name + "_" + help_function
            dispatch_function = self.function_name + "_" + dispatch_function

        code.begin_function(parse_function)
        if self.pre_parse_hook:
            code.add_line(self.pre_parse_hook + ' "$@"')
            code.add_line(None)

        code.define_var("parse_args_print_help", "false")
        code.define_var(self.bash_var_position, 0)

        num_positional_args = self.num_remaining(0)
        if num_positional_args > 0:
            # Before we begin parsing arguments in bash, check if we have zero
            # arguments and set help = True if we do. This is because we
            # expected to have at least one required positional argument, but
            # we didn't, so we have to manually handle it.
            cond = SC.int_var_less_value("#", num_positional_args)
            code.begin_if(cond)
            code.set_var("parse_args_print_help", "true")
            code.end_if()
            code.add_line("")

        # Set default argument values before parsing anything.
        for argument in self.arguments:
            argument.format_bash("prehook", code)

        cond = SC.int_var_greater_value("#", 0)
        code.begin_while(cond)
        code.define_var("arg", "$1")
        code.define_var("do_shift", "true")
        code.add_line("")

        subparser = False
        have_remainder = False
        need_endif = False
        position = 0
        required_positional = 0
        for index, item in enumerate(self.grammar):
            if item == "[options]":
                assert self.options
                for option in self.options:
                    if self.mixed_options_arguments:
                        option.format_bash(code)
                    else:
                        option.format_bash(
                            code,
                            positional=True,
                            var_position=self.bash_var_position,
                            position=position,
                        )
                    need_endif = True
            elif item.startswith("arguments.") and not item.endswith("..."):
                arg_name = item[len("arguments.") :]
                argument = self.find_argument(arg_name)
                assert argument is not None

                argument.position = position
                position += 1
                required_positional += 1

                if argument.value_type == Value.Subparser:
                    subparser = argument

                argument.format_bash("parser", code)
                need_endif = True
            elif item.startswith("arguments.") and item.endswith("..."):
                arg_name = item[len("arguments.") : -len("...")]
                argument = self.find_argument(arg_name)
                assert argument is not None

                argument.position = position
                position += 1
                required_positional += 1

                assert argument.value_type == Value.Array

                additional = self.num_remaining(index + 1)
                argument.format_bash(
                    "parser", code, optional=False, remaining=additional
                )
                need_endif = True
            elif item.startswith("[arguments.") and item.endswith("...]"):
                arg_name = item[len("[arguments.") : -len("...]")]
                argument = self.find_argument(arg_name)
                assert argument is not None

                argument.position = position
                position += 1

                assert argument.value_type == Value.Array

                additional = self.num_remaining(index + 1)
                argument.format_bash(
                    "parser", code, optional=True, remaining=additional
                )
                need_endif = True
            elif item.startswith("[arguments.") and item.endswith("]"):
                arg_name = item[len("[arguments.") : -len("]")]
                argument = self.find_argument(arg_name)
                assert argument is not None

                argument.position = position
                position += 1

                assert argument.value_type != Value.Array

                additional = self.num_remaining(index + 1)
                argument.format_bash(
                    "parser", code, optional=True, remaining=additional
                )
                need_endif = True
            elif (
                self.catch_remainder
                and item.startswith("[vars.")
                and item.endswith("...]")
            ):
                assert item[len("[vars.") : -1 * len("...]")] == self.bash_var_remainder
                assert index == len(self.grammar) - 1

                if need_endif:
                    code.begin_else()
                code.append_array(self.bash_var_remainder, "$arg")
                have_remainder = True
            else:
                raise ValueError(f"Can't handle grammar item {item}")

        if need_endif:
            # When at least one option or argument exists, and the command
            # line argument doesn't fall into either, print the help text.
            # But, we can only do it when we aren't catching the remainder
            # elsewhere.
            if not have_remainder:
                code.begin_else()
                code.set_var("parse_args_print_help", "true")
            code.end_if()

        code.add_line("")
        cond = SC.str_var_equals_value("do_shift", "true")
        code.begin_if(cond)
        code.add_line("shift")
        code.end_if()
        code.end_while()
        code.add_line("")

        last_required_is_array = False
        for item in self.grammar:
            if item.startswith("arguments."):
                last_required_is_array = False
            if not item.startswith("arguments.") or not item.endswith("..."):
                continue

            last_required_is_array = True

            arg_name = item[len("arguments.") : -len("...")]
            argument = self.find_argument(arg_name)

            cond = SC.int_var_equals_value("{#" + argument.var_name + "}", 0)
            code.begin_if(cond)
            code.set_var("parse_args_print_help", "true")
            code.end_if()
            code.add_line("")

        if required_positional > 0:
            if last_required_is_array:
                required_positional -= 1
            cond = SC.int_var_less_value(self.bash_var_position, required_positional)
            code.begin_if(cond)
            code.set_var("parse_args_print_help", "true")
            code.end_if()
            code.add_line("")

        cond = SC.str_var_equals_value("parse_args_print_help", "true")
        code.begin_if(cond)
        code.add_line(help_function)
        code.add_line("return 1")
        code.end_if()
        code.add_line("return 0")
        code.end_function()

        code.begin_function(help_function)
        code.add_line("cat - << " + help_function + "_EOF")
        self.format_help(_file=code, _indent=0, _increment=None)
        code.add_line(help_function + "_EOF", indent=0)
        code.end_function()

        if subparser:
            code.begin_function(dispatch_function)
            if self.pre_dispatch_hook:
                code.add_line(self.pre_dispatch_hook + ' "$@"')
                code.define_var("pre_dispatch_hook_ret", "$?")
                cond = SC.int_var_not_equals_value("pre_dispatch_hook_ret", 0)
                code.begin_if(cond)
                code.add_line("return $pre_dispatch_hook_ret")
                code.end_if
                code.add_line(None)

            for item in sorted(subparser.whitelist):
                cond = SC.str_var_equals_value(subparser.var_name, item)
                code.begin_if_elif(cond)
                code.log_message_if_verbose(
                    "Dispatching: "
                    + item
                    + " | "
                    + subparser.whitelist[item].function_name
                )

                if not subparser.whitelist[item].function_name:
                    raise Exception(
                        "Expected subparser "
                        + item
                        + " of "
                        + self.program_name
                        + " to have function specified"
                    )

                function_call = subparser.whitelist[item].function_name
                if self.catch_remainder:
                    function_call += ' "${' + self.bash_var_remainder + '[@]}"'
                code.add_line(function_call)

            cond = SC.str_var_not_empty(subparser.var_name)
            code.begin_if_elif(cond)
            code.add_line('_handle_dispatch_error "$' + subparser.var_name + '"')
            code.begin_else()
            code.add_line(help_function)
            code.end_if()

            code.end_function()

            for cmd_name in subparser.whitelist:
                sub_cmd = subparser.whitelist[cmd_name]

                if self.program_name:
                    sub_cmd.program_name = (
                        self.program_name + " " + sub_cmd.program_name
                    )
                sub_cmd.format_bash(
                    _code=code, _file=_file, _indent=_indent, _increment=_increment
                )

        if _code is None:
            code.to_file(_file=_file)
