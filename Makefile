# === Variables === #

# Defines which python interpreter to use. This interpreter must have the pip
# module available in order to install dependencies dynamically. However, to
# avoid fetching dependencies from the internet, the following modules should
# be provided in the Python environment:
# - black (format rule)
# - flake8 (lint rule -- called from check)
# - mypy (typecheck rule -- called from check)
PYTHON?=python3

# === Targets === #
#
# We define the following top-level targets that are suggested for use:
#
# - format: formats the source code during development,
# - check: runs the test suite, invokes typechecking, and lints the
#          source code
# - install: installs sharg as a development Python module, using a
#            symlink; when sharg is updated the module is updated as well.
# - distinstall: installs sharg globally, without symlink.
# - ci: invoked during CI integration tests

format:
	${PYTHON} -c 'import black' || ${PYTHON} -m pip install --user black
	${PYTHON} -m black sharg

test: check

check: lint typecheck yaml

lint:
	${PYTHON} -c 'import flake8' || ${PYTHON} -m pip install --user flake8
	python3 -m flake8 --statistics --append-config=.flake8.cfg sharg

typecheck:
	${PYTHON} -c 'import mypy' || ${PYTHON} -m pip install --user mypy
	${PYTHON} -m mypy sharg

yaml:
	${PYTHON} -m sharg --bash tests/yaml/args.sh tests/yaml/p.yml
	cd tests/yaml && ./test_exec.sh

install:
	${PYTHON} -m pip install --user -e .

distinstall:
	${PYTHON} -m pip install .

ci: format-check check

format-check:
	${PYTHON} -c 'import black' || ${PYTHON} -m pip install --user black
	${PYTHON} -m black --check sharg
