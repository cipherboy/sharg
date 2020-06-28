from enum import Enum

from .shell import ShellConditional as SC


class Value(Enum):
    FalseTrue = 1
    TrueFalse = 2
    Directory = 3
    File = 4
    String = 5
    Whitelist = 6
    Substring = 7
    Subparser = 8
    Array = 9
    Constant = 10

    def format_bash(
        self,
        code,
        long_name,
        var_name,
        source,
        do_shift=False,
        whitelist=None,
        value=None,
    ):
        tmp_var = "__tmp_" + var_name

        if self == Value.FalseTrue:
            code.set_var(var_name, "true")
        elif self == Value.TrueFalse:
            code.set_var(var_name, "false")
        elif self == Value.Directory:
            code.define_var(tmp_var, source)
            if do_shift:
                code.add_line("shift")
            code.add_line("")

            cond = SC.not_is_dir("$" + tmp_var)
            code.begin_if(cond)
            code.add_line(
                '_handle_parse_error "' + long_name + '" ' + '"$' + tmp_var + '"'
            )
            code.begin_else()
            code.set_var(var_name, "$" + tmp_var)
            code.end_if()
        elif self == Value.File:
            code.define_var(tmp_var, source)
            if do_shift:
                code.add_line("shift")
            code.add_line("")

            cond = SC.not_is_file("$" + tmp_var)
            code.begin_if(cond)
            code.add_line(
                '_handle_parse_error "' + long_name + '" ' + '"$' + tmp_var + '"'
            )
            code.begin_else()
            code.set_var(var_name, "$" + tmp_var)
            code.end_if()
        elif self == Value.String:
            code.set_var(var_name, source)
            if do_shift:
                code.add_line("shift")
        elif self in (Value.Whitelist, Value.Subparser):
            code.define_var(tmp_var, source)
            if do_shift:
                code.add_line("shift")
            code.add_line("")

            conds = []
            for item in sorted(whitelist):
                cond = SC.str_var_equals_value(tmp_var, item)
                full_cond = [cond]
                if self == Value.Subparser:
                    for alias in whitelist[item].aliases:
                        full_cond.append(SC.str_var_equals_value(tmp_var, alias))

                if len(full_cond) > 1:
                    cond = SC.c_or(full_cond)

                conds.append((item, cond))

            value, cond = conds[0]
            code.begin_if(cond)
            code.set_var(var_name, value)
            for value, cond in conds[1:]:
                code.begin_elif(cond)
                code.set_var(var_name, value)
            code.begin_else()
            code.add_line(
                '_handle_parse_error "' + long_name + '" ' + '"$' + tmp_var + '"'
            )
            code.end_if()
        elif self == Value.Array:
            code.append_array(var_name, source)
            if do_shift:
                code.add_line("shift")
        elif self == Value.Constant:
            code.set_var(var_name, value)
