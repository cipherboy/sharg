import argparse
from .config import parse_yaml


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--bash",
        type=argparse.FileType("w"),
        help="Path to save bash code to",
        required=False,
    )
    parser.add_argument(
        "--summary",
        action="store_true",
        help="Generate summary of the help text",
        required=False,
    )
    parser.add_argument(
        "yaml", type=argparse.FileType("r"), help="Path to load sharg YAML from"
    )
    return parser.parse_args()


def main():
    args = parse_args()
    cmd_line = parse_yaml(args.yaml)

    if args.summary:
        cmd_line.format_help()
    if args.bash:
        cmd_line.format_bash(_file=args.bash)


if __name__ == "__main__":
    main()
