class ShellCodeGen:
    code = []
    stack = []

    bash_function_style = True
    function_error = False

    indent_char = " "
    indent = 0
    increment = 0

    def add_line(self, line):
        prefix = self.indent_char * self.indent
        self.add_line(prefix + line)

    def begin_block(self):
        self.indent += self.increment

    def end_block(self):
        self.indent -= self.increment

    def begin_function(self, name):
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
        assert len(self.stack) > 0 and self.stack.pop() == 'function'

        self.end_block()

        line = ""
        if self.function_error:
            line += ")"
        line += "}"

        self.add_line(line)

    def begin_while(self, conditional):
        self.add_line("while " + str(conditional) + "; do")
        self.begin_block()
        self.stack.append('while')

    def end_while(self):
        assert len(self.stack) > 0 and self.stack.pop() == 'while'

        self.end_block()
        self.add_line("done")

    def begin_for(self, conditional):
        self.add_line("for " + str(conditional) + "; do")
        self.begin_block()
        self.stack.append('for')

    def end_for(self):
        assert len(self.stack) > 0 and self.stack.pop() == 'for'

        self.end_block()
        self.add_line("done")

    def begin_if(self, conditional):
        self.add_line("if " + str(conditional) + "; then")
        self.begin_block()
        self.stack.append('if')

    def begin_elif(self, conditional):
        assert len(self.stack) > 0 and self.stack.pop() == 'if'
        self.end_block()

        self.add_line("elif " + str(conditional) + "; then")
        self.begin_block()
        self.stack.append('if')

    def end_if(self):
        assert len(self.stack) > 0 and self.stack.pop() == 'if'
        self.end_block()
        self.add_line("fi")

    def set_var(self, var_name, value):
        self.add_line(var_name + '="' + value + '"')

    def define_var(self, var_name, value):
        self.add_line('local ' + var_name + '="' + value + '"')


class ShellConditional:
    def __str__():
        pass
