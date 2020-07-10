import sys
from typing import Dict, List, Optional

from .help import HelpText, HelpType
from .shell import ShellConditional as SC
from .shell import ShellCodeGen as SCG
from .value import Value

"""
This source file contains only the Argument class, described more
below.
"""


class Argument:
    """
    The Argument class represents a single logical argument passed on the
    command line.

    An argument differs from an option in that the latter usually begins with
    a prefix ('-', '--', or '/') and arguments are positional whereas options
    can usually be in any order. Note that when options take a value, the
    value is not called an argument.

    Arguments can take various types ("value_type") and can contain aliases
    mapping certain values to others.
    """

    # Human readable name of this argument.
    name = None

    # Name of this argument, made into a "safe" variable name.
    var_name = None

    # Help text for this argument.
    help_text: Optional[HelpText] = None

    # Position of this argument.
    position: int

    # Variable name which contains the current argument position.
    var_position: str

    # Type of this positional argument.
    value_type: Value

    # A whitelist of allowed values, when used.
    whitelist: List[str] = []

    # Aliases mapping one value to another, when used.
    aliases: Dict[str, str] = {}

    # The actual value of this argument, when the argument is a Constant
    # value_type. This is less useful with arguments as the value on the
    # command line is discard.
    value = None

    # The default value of this argument. Used for setting arguments ahead
    # of values.
    default_value = None

    def __init__(
        self,
        name=None,
        var_position=None,
        position=None,
        argument_type=None,
        whitelist=None,
        value=None,
        default=None,
    ):
        self.name = name
        self.var_position = var_position
        self.position = position
        self.help_text = HelpText(self, HelpType.Argument)
        self.var_name = name.replace("-", "_")
        self.value_type = argument_type
        self.whitelist = whitelist
        self.value = value
        self.default_value = default

    def __groups__(self):
        """
        Get all of the groups in the whitelist of subcommands.
        """
        all_groups = set()

        for key in self.whitelist:
            group = self.whitelist[key].group

            # Some subcommands might not have a group; only add it to the
            # set if there is a group.
            if group:
                all_groups.add(group)

        return sorted(all_groups)

    def __by_group__(self, group):
        """
        Get all the subcommands within the specified group.
        """
        all_keys = set()

        for key in self.whitelist:
            subcmd = self.whitelist[key]
            if subcmd.group == group:
                all_keys.add(key)

        return sorted(all_keys)

    def format_help(self, _file=sys.stdout, _indent=0, _increment=2):
        """
        Format the help text for this positional argument. Usually this
        is just a single help line, but when the argument dispatches
        subcommands, we have to display additional information about what
        values can be passed.
        """

        indent2 = " " * (_indent + _increment)
        indent3 = " " * (_indent + _increment + _increment)

        self.help_text.format_help(_file=_file, _indent=_indent, _increment=_increment)

        if self.value_type == Value.Subparser:
            groups = self.__groups__()

            if groups:
                for group in sorted(groups):
                    print(indent2 + group + ":", file=_file)
                    for key in self.__by_group__(group):
                        print(
                            indent3
                            + "- "
                            + key
                            + ": "
                            + self.whitelist[key].description,
                            file=_file,
                        )
                    print("", file=_file)

                print(indent2 + "Other commands:", file=_file)
                for key in self.__by_group__(None):
                    print(
                        indent3 + "- " + key + ": " + self.whitelist[key].description,
                        file=_file,
                    )
            else:
                for key in sorted(self.whitelist.keys()):
                    print(
                        indent2 + "- " + key + ": " + self.whitelist[key].description,
                        file=_file,
                    )

    def format_bash(self, context, code: SCG, optional=False, remaining=0):
        if context == "prehook":
            self.format_bash_prehook(code, optional, remaining)
        elif context == "parser":
            self.format_bash_parser(code, optional, remaining)
        else:
            assert False

    def format_bash_prehook(self, code: SCG, optional, remaining):
        if self.default_value:
            code.set_var(self.var_name, self.default_value)

    def format_bash_parser(self, code: SCG, optional, remaining):
        if not optional or remaining == 0:
            cond = SC.int_var_equals_value(self.var_position, self.position)
            code.begin_if_elif(cond)
            if self.value_type == Value.Array:
                # $# contains this argument we just grabbed, so we need to
                # check for remaining+1 here.
                if remaining > 0:
                    cond = SC.int_var_greater_value("#", remaining + 1)
                    code.begin_if(cond)
                    code.increment_var(self.var_position)
                    code.end_if()
                self.value_type.format_bash(
                    code,
                    self.name,
                    self.var_name,
                    "$arg",
                    do_shift=False,
                    whitelist=self.whitelist,
                )
            else:
                # We can only hold one value anyways, increment the variable.
                code.increment_var(self.var_position)
                self.value_type.format_bash(
                    code,
                    self.name,
                    self.var_name,
                    "$arg",
                    do_shift=False,
                    whitelist=self.whitelist,
                )
        else:
            # Assume we have an unambiguous grammar; otherwise, we'll be in
            # trouble. We should've already bailed out if we haven't...
            #
            # In this case, we have additional required arguments afterwards.
            # If, when we're done parsing this argument (its an array), and
            # we still have room to finish parsing other arguments, don't
            # increment position. Otherwise, increment it.
            cond = SC.int_var_equals_value(self.var_position, self.position)
            code.begin_if_elif(cond)

            # Decide whether to skip processing this variable as the argument
            # in this position.
            cond = SC.int_var_less_equals_value("#", remaining)
            code.begin_if(cond)
            code.set_var("do_shift", "false")
            code.increment_var(self.var_position)
            code.begin_else()

            if self.value_type == Value.Array:
                # $# contains this argument we just grabbed, so we need to
                # check for remaining+1 here.
                cond = SC.int_var_less_equals_value("#", remaining + 1)
                code.begin_if(cond)
                code.increment_var(self.var_position)
                code.end_if()
                self.value_type.format_bash(
                    code,
                    self.name,
                    self.var_name,
                    "$arg",
                    do_shift=False,
                    whitelist=self.whitelist,
                    value=self.value,
                )

            else:
                # We can only hold one value anyways, increment the variable.
                code.increment_var(self.var_position)
                self.value_type.format_bash(
                    code,
                    self.name,
                    self.var_name,
                    "$arg",
                    do_shift=False,
                    whitelist=self.whitelist,
                    value=self.value,
                )

            code.end_if()
