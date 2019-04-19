#!/usr/bin/python3

import sharg
import sys

c = sharg.CommandLine(prog="p", example="p cat my_secret", catch_remainder=True)
c.bash_var_remainder = "remainder"

o1 = c.add_option("password-store-dir", "P",
                  "path to the password storage directory",
                  sharg.Value.Directory)
o2 = c.add_option("gnupg-home-dir", "G",
                  "path to the GnuPG home directory",
                   sharg.Value.Directory)
_whitelist = ["ls"]
a = c.add_argument('cmd',
                   'p command to run.',
                   argument_type=sharg.Value.Whitelist,
                   whitelist=_whitelist)

if len(sys.argv) > 1 and sys.argv[1] == 'help':
    c.format_help()
else:
    c.format_bash()
