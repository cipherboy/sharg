from typing import List, Optional

"""
This file contains a class to help describe Help text
"""


class HelpText:
    """
    This class is used for displaying and formatting help and informational
    text associated with command line parameters.

    This includes short descriptions, long descriptions, example usages, and
    other related examples.
    """

    name: str

    short_desc: Optional[str] = None
    long_desc: Optional[str] = None

    examples: List[str] = []

    def __init__(self, name: str, short_desc=None, long_desc=None, examples=None):
        self.name = name
        self.short_desc = short_desc
        self.long_desc = long_desc
        self.examples = []
        if examples:
            self.examples = examples[:]
