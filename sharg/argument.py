import sys
from typing import Dict, List, Optional

from .shell import ShellConditional as SC
from .shell import ShellCodeGen as SCG
from .value import Value


class Argument:
    name = None
    var_name = None
    help_text = None

    position: Optional[int] = None
    var_position: Optional[str] = None

    value_type = None

    whitelist: List[str] = []
    aliases: Dict[str, str] = {}
    value = None

    default_value = None

    def __init__(
        self,
        name=None,
        var_position=None,
        position=None,
        help_text=None,
        argument_type=None,
        whitelist=None,
        value=None,
        default=None,
    ):
        self.name = name
        self.var_position = var_position
        self.position = position
        self.help_text = help_text
        self.var_name = name.replace("-", "_")
        self.value_type = argument_type
        self.whitelist = whitelist
        self.value = value
        self.default_value = default

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
        indent2 = " " * (_indent + _increment)
        indent3 = " " * (_indent + _increment + _increment)

        print(indent + self.name, end="", file=_file)
        if self.help_text:
            print(": " + self.help_text, end="", file=_file)
        print("", file=_file)

        if self.value_type == Value.Subparser:
            groups, _ = self.__groups__()

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
                for key in self.whitelist:
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
        assert isinstance(self.var_position, str)
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
