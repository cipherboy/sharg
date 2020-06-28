PYTHON?=python3

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

ci: format-check check

format-check:
	${PYTHON} -c 'import black' || ${PYTHON} -m pip install --user black
	${PYTHON} -m black --check sharg
