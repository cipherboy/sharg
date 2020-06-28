from enum import Enum
import sys
from typing import List, Optional

"""
This file contains a class to help describe Help text, plus an enum to
describe what the help text is for.
"""


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

    def format_help_argument(self, _file=sys.stdout, _indent=0, _increment=2):
        indent = " " * _indent

        print(indent + self.parent.name, end="", file=_file)
        if self.short_desc:
            print(": " + self.short_desc, end="", file=_file)
        print("", file=_file)

    def format_markdown(self, _file=sys.stdout, _indent=0, _increment=2):
        pass
