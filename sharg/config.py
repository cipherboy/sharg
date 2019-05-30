import io
import os
import yaml

from typing import Dict

from .commandline import CommandLine
from .value import Value


def parse_yaml(yaml_file):
    contents = yaml_file

    if os.path.exists(yaml_file):
        yaml_file = open(yaml_file, 'r')
    if isinstance(yaml_file, io.IOBase):
        contents = yaml_file.read()

    obj = yaml.safe_load(contents)
    return parse_dict(obj)

def __missing_key__(obj, value_key, value_type, parse_path="", reason=""):
    msg = "\n\nMissing key in the parsed config:\n"
    msg += "\tkey: %s of %s\n" % (str(value_key), str(value_type))
    if parse_path:
        msg += "\tpath: %s\n" % parse_path
    if reason:
        msg += "\treason: %s\n" % reason
    if len(str(obj)) < 500:
        msg += "\nConfig Context:\n"
        msg += str(obj)
    raise Exception(msg)

def __wrong_type__(obj, value_key, actual_type, value_type, parse_path="", reason=""):
    msg = "\n\nWrong type in the parsed config:\n"
    msg += "\tkey: %s of %s\n" % (str(value_key), str(actual_type))
    msg += "\texpected: %s\n" % (str(value_type))
    if parse_path:
        msg += "\tpath: %s\n" % parse_path
    if reason:
        msg += "\treason: %s\n" % reason
    if len(str(obj)) < 500:
        msg += "\nConfig Context:\n"
        msg += str(obj)

    raise Exception(msg)

def __not_empty__(obj, value_key, parse_path="", reason=""):
    msg = "\n\nExpected key to be empty but wasn't:\n"
    msg += "\tkey: %s of %s\n" % (value_key, str(type(obj[value_key])))
    if parse_path:
        msg += "\tpath: %s\n" % parse_path
    if reason:
        msg += "\treason: %s\n" % reason
    if len(str(obj)) < 500:
        msg += "\nConfig Context:\n"
        msg += str(obj)

    raise Exception(msg)

def assert_type(obj, value_key, value_type, parse_path):
    if not isinstance(obj[value_key], value_type):
        __wrong_type__(obj, value_key, type(obj[value_key]), value_type, parse_path)
    return True

def assert_in(obj, value_key, value_type, parse_path):
    if not value_key in obj:
        __missing_key__(obj, value_key, value_type, parse_path)

    assert_type(obj, value_key, value_type, parse_path)

def assert_if_in(obj, value_key, value_type, parse_path):
    if not value_key in obj:
        return False

    assert_type(obj, value_key, value_type, parse_path)
    return True

def assert_empty(obj, key, parse_path, reason=""):
    if obj[key]:
        __not_empty__(obj, key, parse_path=parse_path, reason=reason)

def type_validate_option(option, parse_path=""):
    assert_in(option, "name", str, parse_path)
    assert_in(option, "description", str, parse_path)
    assert_if_in(option, "short", str, parse_path)

    if not assert_if_in(option, "type", str, parse_path):
        option["type"] = "String"
    if not assert_if_in(option, "scope", str, parse_path):
        option["scope"] = "local"

    if assert_if_in(option, "aliases", list, parse_path):
        for num in range(0, len(option["aliases"])):
            alias_parse_path = parse_path + ".aliases"
            assert_type(option["aliases"], num, str, alias_parse_path)

def type_validate_argument(arg, parse_path=""):
    assert_in(arg, "name", str, parse_path)
    assert_in(arg, "description", str, parse_path)

    if not assert_if_in(arg, "type", str, parse_path):
        arg['type'] = "String"

    if arg["type"] == "subparser":
        assert_in(arg, "whitelist", list, parse_path)

        for num, item in enumerate(arg["whitelist"]):
            item_parse_path = parse_path + ".whitelist[" + str(num) + "]"
            assert_in(item, "name", str, item_parse_path)
            type_validate(item, item_parse_path)

def type_validate(obj, parse_path=""):
    assert_in(obj, "name", str, parse_path)
    assert_in(obj, "description", str, parse_path)

    if not assert_if_in(obj, "options", list, parse_path):
        obj["options"] = []
    if not assert_if_in(obj, "arguments", list, parse_path):
        obj["arguments"] = []
    if not assert_if_in(obj, "grammar", list, parse_path):
        assert_empty(obj, "options", parse_path,
                     reason="To specify options in a parser, you must specify a grammar.")
        assert_empty(obj, "arguments", parse_path,
                     reason="To specify arguments in a parser, you must specify a grammar.")

        obj["grammar"] = []
    if not assert_if_in(obj, "aliases", list, parse_path):
        obj["aliases"] = []

    for num, option in enumerate(obj["options"]):
        option_parse_path = parse_path + ".options[" + str(num) + "]"
        type_validate_option(option, option_parse_path)

    for num, argument in enumerate(obj["arguments"]):
        argument_parse_path = parse_path + ".arguments[" + str(num) + "]"
        type_validate_argument(argument, argument_parse_path)

    for num in range(0, len(obj["grammar"])):
        grammar_parse_path = parse_path + ".grammar[" + str(num) + "]"
        assert_type(obj["grammar"], num, str, grammar_parse_path)

def constraint_validate(obj, parse_path=""):
    pass

def parse_option(option: dict, result: CommandLine):
    _o_name = option.get("name", None)
    _o_short = option.get("short", None)
    _o_help = option.get("description", None)
    _o_type = option.get("type", None)
    _o_value = Value[_o_type]

    result.add_option(_o_name, short_name=_o_short, help_text=_o_help,
                      option_type=_o_value)

def parse_whitelist(obj: dict) -> Dict[str, CommandLine]:
    whitelist: Dict[str, CommandLine] = {}

    if obj is None:
        return whitelist

    for item in obj:
        subparser = parse_dict(item)
        key = item["name"]
        whitelist[key] = subparser

    return whitelist

def parse_argument(argument: dict, result: CommandLine):
    _a_name = argument.get("name", None)
    _a_help = argument.get("description", None)
    _a_type = argument.get("type", None)
    _a_value = Value[_a_type]
    _a_dict = argument.get("whitelist", None)
    _a_whitelist = parse_whitelist(_a_dict)

    result.add_argument(_a_name, help_text=_a_help, argument_type=_a_value,
                        whitelist=_a_whitelist)

def parse_dict(obj: dict) -> CommandLine:
    type_validate(obj, parse_path="")
    constraint_validate(obj, parse_path="")

    _prog = obj.get("name", None)
    _usage = obj.get("usage", None)
    _description = obj.get("description", None)
    _group = obj.get("group", None)
    _example = obj.get("example", None)
    _epilog = obj.get("epilog", None)
    _equals = obj.get("equals", None)
    _unix = obj.get("unix", None)
    _add_help = obj.get("add_help", True)
    _catch_remainder = obj.get("catch_remainder", False)
    _aliases = obj.get("aliases", [])
    _grammar = obj.get("grammar", [])
    _function_name = obj.get("function", None)

    result: CommandLine = CommandLine(prog=_prog, usage=_usage,
                                      description=_description, group=_group,
                                      example=_example, epilog=_epilog,
                                      equals=_equals, unix=_unix,
                                      add_help=_add_help,
                                      catch_remainder=_catch_remainder,
                                      aliases=_aliases, grammar=_grammar,
                                      function_name=_function_name)

    _remainder = obj.get("remainder", None)
    if _remainder:
        result.bash_var_remainder = _remainder

    for option in obj["options"]:
        parse_option(option, result)

    for argument in obj["arguments"]:
        parse_argument(argument, result)

    return result
