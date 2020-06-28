PYTHON?=python3

format:
	${PYTHON} -c 'import black' || ${PYTHON} -m pip install --user black
	${PYTHON} -m black sharg/

lint:
	${PYTHON} -c 'import flake8' || ${PYTHON} -m pip install --user flake8
	python3 -m flake8 --statistics --append-config=.flake8.cfg sharg

test: check

check: lint typecheck yaml 

typecheck:
	${PYTHON} -c 'import mypy' || ${PYTHON} -m pip install --user mypy
	${PYTHON} -m mypy sharg

yaml:
	${PYTHON} -m sharg --bash tests/yaml/args.sh tests/yaml/p.yml

install:
	${PYTHON} -m pip install --user -e .
