"""
A library to generate command line (shell) argument parsers for a
variety of target languages.

This currently includes Bash, Bash Completion, and manual pages, but
could be extended to include any number of languages or libraries.
"""

from .shell import ShellCodeGen
from .shell import ShellConditional

from .value import Value
from .argument import Argument
from .option import Option
from .commandline import CommandLine

from .config import parse_yaml, parse_dict
