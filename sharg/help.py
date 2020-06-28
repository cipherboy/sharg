"""
This file contains a class to help describe Help text, plus an enum to
describe what the help text is for.
"""

from enum import Enum
import sys
from typing import List, Optional

from .value import Value


class HelpType(Enum):
    """
    This enum is used to describe the type of object which holds the help
    text.
    """

    Argument = 1
    Option = 2
    CommandLine = 3


class HelpText:
    """
    This class is used for displaying and formatting help and informational
    text associated with command line parameters.

    This includes short descriptions, long descriptions, example usages, and
    other related examples.
    """

    parent = None
    help_type: HelpType

    short_desc: Optional[str] = None
    long_desc: Optional[str] = None

    examples: List[str] = []

    def __init__(
        self,
        parent: str,
        help_type: HelpType,
        short_desc=None,
        long_desc=None,
        examples=None,
    ):
        self.parent = parent
        self.help_type = help_type
        self.short_desc = short_desc
        self.long_desc = long_desc
        self.examples = []

        if examples:
            self.examples = examples[:]

    def format_help(self, _file=sys.stdout, _indent=0, _increment=2):
        if self.help_type == HelpType.Argument:
            assert self.parent is not None
            self.format_help_argument(
                _file=_file, _indent=_indent, _increment=_increment
            )
        elif self.help_type == HelpType.Option:
            assert self.parent is not None
            self.format_help_option(_file=_file, _indent=_indent, _increment=_increment)

    def format_help_argument(self, _file=sys.stdout, _indent=0, _increment=2):
        indent = " " * _indent

        print(indent + self.parent.name, end="", file=_file)
        if self.short_desc:
            print(": " + self.short_desc, end="", file=_file)
        print("", file=_file)

    def format_help_option(self, _file=sys.stdout, _indent=0, _increment=2):
        indent = " " * _indent
        indent2 = " " * (_indent + _increment)

        space = False

        print(indent, end="", file=_file)
        if self.parent.long_name:
            print("--" + self.parent.long_name, end="", file=_file)
            space = True
        if self.parent.short_name:
            if space:
                print(", ", end="", file=_file)
                space = False
            print("-" + self.parent.short_name, end="", file=_file)
            space = True
        if self.parent.value_type == Value.Directory:
            print(" <dir>", end="", file=_file)
        elif self.parent.value_type == Value.File:
            print(" <file>", end="", file=_file)
        elif self.parent.value_type == Value.String:
            print(" <str>", end="", file=_file)
        if self.short_desc:
            if space:
                print(": ", end="", file=_file)
                space = False
            print(self.short_desc, end="", file=_file)
            space = True
        print("", file=_file)
        if self.parent.aliases:
            joined_aliases = ", ".join(self.parent.aliases)
            print(indent2 + "Aliases: " + joined_aliases, end="", file=_file)

    def format_markdown(self, _file=sys.stdout, _indent=0, _increment=2):
        pass
