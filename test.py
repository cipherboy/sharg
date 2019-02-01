#!/usr/bin/python3

import sharg

c = sharg.CommandLine(prog="p", example="p cat my_secret")
o1 = c.add_option("password-store-dir", "P", "path to the password storage directory")
o2 = c.add_option("gnupg-home-dir", "G", "path to the GnuPG home directory")

c.format_help()
