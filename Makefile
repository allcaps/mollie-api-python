# use virtualenv or virtualenv-wrapper location based on availability
ifdef WORKON_HOME
	VIRTUALENV = $(WORKON_HOME)/mollie-api-python
endif
ifndef VIRTUALENV
	VIRTUALENV = $(PWD)/env
endif

PYTHON_VERSION = 3.8
PYTHON = $(VIRTUALENV)/bin/python


.PHONY: virtualenv
virtualenv: $(VIRTUALENV)  # alias
$(VIRTUALENV):
	$(shell which python$(PYTHON_VERSION)) -m venv $(VIRTUALENV)
	$(PYTHON) -m pip install --upgrade pip setuptools wheel


.PHONY: develop
develop: mollie_api_python.egg-info # alias
mollie_api_python.egg-info: virtualenv
	$(PYTHON) -m pip install -r test_requirements.txt
	$(PYTHON) -m pip install -e .


.PHONY: test
test: develop
	$(PYTHON) -m flake8
	$(PYTHON) -m mypy --config mypy.ini mollie/
	$(PYTHON) -m pytest
	# Jinja, https://data.safetycli.com/v/70612/97c
	$(PYTHON) -m safety check --ignore 70612


dist/mollie_api_python-*-py3-none-any.whl: virtualenv
	$(PYTHON) -m pip install --upgrade build
	$(PYTHON) -m build --wheel


dist/mollie-api-python-*.tar.gz: virtualenv
	$(PYTHON) -m pip install --upgrade build
	$(PYTHON) -m build --sdist


.PHONY: build
build: dist/mollie_api_python-*-py3-none-any.whl dist/mollie-api-python-*.tar.gz


.PHONY: clean
clean:
	rm -f -r build/ dist/ htmlcov/ .eggs/ mollie_api_python.egg-info .pytest_cache .mypy_cache
	find . -type f -name '*.pyc' -delete
	find . -type d -name __pycache__ -delete


.PHONY: realclean
realclean: clean
	rm -f -r $(VIRTUALENV)
