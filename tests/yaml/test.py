#!/usr/bin/python3

import sys
import sharg

def main():
    cmd = sharg.parse_yaml(sys.argv[1])

    if len(sys.argv) > 2 and 'help' in sys.argv:
        cmd.format_help()
    else:
        cmd.format_bash()

if __name__ == "__main__":
    main()
