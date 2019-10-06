import sys
from typing import Optional, List


class ShellCodeGen:
    code: List[str] = []
    stack: List[str] = []

    bash_function_style: bool = True
    function_error: bool = False

    indent_char: str = " "
    indent: int = 0
    increment: int = 0

    write_buffer: str = ""

    def add_line(self, line: str, indent: Optional[int] = None):
        if indent is None:
            indent = self.indent

        prefix = self.indent_char * indent
        if line:
            self.code.append(prefix + line)
        else:
            self.code.append("")

    def begin_block(self):
        self.indent += self.increment

    def end_block(self):
        self.indent -= self.increment

    def begin_function(self, name: str):
        line = ""
        if self.bash_function_style:
            line += "function "
        line += name + "() {"
        if self.function_error:
            line += "("

        self.add_line(line)
        self.begin_block()
        self.stack.append('function')

        if self.function_error:
            self.add_line("set -e")

    def end_function(self):
        assert self.stack and self.stack.pop() == 'function'

        self.end_block()

        line = ""
        if self.function_error:
            line += ")"
        line += "}"

        self.add_line(line)

    def begin_while(self, conditional: str):
        self.add_line("while " + str(conditional) + "; do")
        self.begin_block()
        self.stack.append('while')

    def end_while(self):
        assert self.stack and self.stack.pop() == 'while'

        self.end_block()
        self.add_line("done")

    def begin_for(self, conditional: 'ShellConditional'):
        self.add_line("for " + str(conditional) + "; do")
        self.begin_block()
        self.stack.append('for')

    def end_for(self):
        assert self.stack and self.stack.pop() == 'for'

        self.end_block()
        self.add_line("done")

    def begin_if(self, conditional: 'ShellConditional'):
        self.add_line("if " + str(conditional) + "; then")
        self.begin_block()
        self.stack.append('if')

    def begin_elif(self, conditional: 'ShellConditional'):
        assert self.stack and self.stack.pop() == 'if'
        self.end_block()

        self.add_line("elif " + str(conditional) + "; then")
        self.begin_block()
        self.stack.append('if')

    def begin_else(self):
        assert self.stack and self.stack.pop() == 'if'
        self.end_block()

        self.add_line("else")
        self.begin_block()
        self.stack.append('if')

    def begin_if_elif(self, conditional: 'ShellConditional'):
        if self.stack[-1] != "if":
            return self.begin_if(conditional)
        return self.begin_elif(conditional)

    def end_if(self):
        assert self.stack and self.stack.pop() == 'if'
        self.end_block()
        self.add_line("fi")

    def set_var(self, var_name: str, value):
        self.add_line(var_name + '="' + str(value) + '"')

    def define_var(self, var_name: str, value):
        self.add_line('local ' + var_name + '="' + str(value) + '"')

    def export_var(self, var_name: str, value):
        self.add_line('export ' + var_name + '="' + str(value) + '"')

    def increment_var(self, var_name: str, amount: int = 1):
        self.add_line(var_name + '=$((' + var_name + ' + ' + str(amount) + '))')

    def append_array(self, var_name: str, value):
        self.add_line(var_name + '+=("' + str(value) + '")')

    def write(self, line: str):
        self.write_buffer += line
        if line.endswith("\n"):
            parts = self.write_buffer.split('\n')
            for part in parts[:-1]:
                self.code.append(part)
            self.write_buffer = ''

    def to_file(self, _file=sys.stdout, allow_partial=False):
        if not allow_partial:
            assert not self.stack

        for line in self.code:
            print(line, file=_file)


class ShellConditional:
    c_type = ""
    lhs = ""
    operator = ""
    rhs = ""
    parts = []

    def __init__(self):
        self.c_type = ""
        self.lhs = ""
        self.operator = ""
        self.rhs = ""
        self.parts = []

    @classmethod
    def str_var_equals_value(cls, var_name: str, value: str):
        obj = cls()
        obj.lhs = 'x$' + var_name
        obj.operator = '=='
        obj.rhs = 'x' + value
        obj.c_type = 'string'
        return obj

    @classmethod
    def substr_var_equals_value(cls, var_name: str, value: str):
        obj = cls()
        obj.lhs = 'x${' + var_name + ':0:' + str(len(value)) + '}'
        obj.operator = '=='
        obj.rhs = 'x' + value
        obj.c_type = 'string'
        return obj

    @classmethod
    def str_var_not_equals_value(cls, var_name, value):
        obj = cls()
        obj.lhs = 'x$' + var_name
        obj.operator = '!='
        obj.rhs = 'x' + value
        obj.c_type = 'string'
        return obj

    @classmethod
    def str_var_equals_var(cls, lhs_var, rhs_var):
        obj = cls()
        obj.lhs = 'x$' + lhs_var
        obj.operator = '=='
        obj.rhs = 'x' + rhs_var
        obj.c_type = 'string'
        return obj

    @classmethod
    def str_var_not_equals_var(cls, lhs_var, rhs_var):
        obj = cls()
        obj.lhs = 'x$' + lhs_var
        obj.operator = '!='
        obj.rhs = 'x' + rhs_var
        obj.c_type = 'string'
        return obj

    @classmethod
    def str_var_empty(cls, var_name):
        obj = cls()
        obj.c_type = 'check'
        obj.operator = '-z'
        obj.rhs = '$' + var_name
        return obj

    @classmethod
    def str_var_not_empty(cls, var_name):
        obj = cls()
        obj.c_type = 'check'
        obj.operator = '! -z'
        obj.rhs = '$' + var_name
        return obj

    @classmethod
    def int_var_greater_value(cls, var_name, value):
        assert isinstance(value, int)

        obj = cls()
        obj.lhs = '$' + var_name
        obj.operator = '>'
        obj.rhs = str(value)
        obj.c_type = 'numeric'
        return obj

    @classmethod
    def int_var_greater_equals_value(cls, var_name, value):
        assert isinstance(value, int)

        obj = cls()
        obj.lhs = '$' + var_name
        obj.operator = '>='
        obj.rhs = str(value)
        obj.c_type = 'numeric'
        return obj

    @classmethod
    def int_var_equals_value(cls, var_name, value):
        assert isinstance(value, int)

        obj = cls()
        obj.lhs = '$' + var_name
        obj.operator = '=='
        obj.rhs = str(value)
        obj.c_type = 'numeric'
        return obj

    @classmethod
    def int_var_less_equals_value(cls, var_name, value):
        assert isinstance(value, int)

        obj = cls()
        obj.lhs = '$' + var_name
        obj.operator = '<='
        obj.rhs = str(value)
        obj.c_type = 'numeric'
        return obj

    @classmethod
    def int_var_less_value(cls, var_name, value):
        assert isinstance(value, int)

        obj = cls()
        obj.lhs = '$' + var_name
        obj.operator = '<'
        obj.rhs = str(value)
        obj.c_type = 'numeric'
        return obj

    @classmethod
    def is_dir(cls, path):
        obj = cls()
        obj.c_type = 'check'
        obj.operator = '-d'
        obj.rhs = path
        return obj

    @classmethod
    def not_is_dir(cls, path):
        obj = cls()
        obj.c_type = 'check'
        obj.operator = '! -d'
        obj.rhs = path
        return obj

    @classmethod
    def is_file(cls, path):
        obj = cls()
        obj.c_type = 'check'
        obj.operator = '-f'
        obj.rhs = path
        return obj

    @classmethod
    def not_is_file(cls, path):
        obj = cls()
        obj.c_type = 'check'
        obj.operator = '! -f'
        obj.rhs = path
        return obj

    @classmethod
    def c_and(cls, *args):
        obj = cls()
        obj.operator = '&&'
        obj.c_type = 'joined'
        obj.parts = []

        for arg in args:
            if isinstance(arg, (str, ShellConditional)):
                obj.parts.append(str(arg))
            else:
                for arg_part in arg:
                    obj.parts.append(str(arg_part))

        return obj

    @classmethod
    def c_or(cls, *args):
        obj = cls()
        obj.operator = '||'
        obj.c_type = 'joined'
        obj.parts = []

        for arg in args:
            if isinstance(arg, (str, ShellConditional)):
                obj.parts.append(str(arg))
            else:
                for arg_part in arg:
                    obj.parts.append(str(arg_part))

        return obj

    def __str__(self):
        line = ""
        if self.c_type == 'string':
            line = '[ "' + self.lhs + '" ' + self.operator + ' "' + \
                   self.rhs + '" ]'
        elif self.c_type == 'numeric':
            line = '(( ' + self.lhs + ' ' + self.operator + ' ' + \
                   self.rhs + ' ))'
        elif self.c_type == 'check':
            line = '[ ' + self.operator + ' "' + self.rhs + '" ]'
        elif self.c_type == 'joined':
            str_inner = map(str, self.parts)
            line = (' ' + self.operator + ' ').join(str_inner)
        else:
            raise Exception("Unknown conditional type: %s" % self.c_type)

        return line
