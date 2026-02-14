.PHONY: install install-cpu install-gpu format lint test clean check all

install: install-cpu
	uv run pre-commit install

install-cpu:
	uv sync --extra cpu --extra dev --extra export

install-gpu:
	uv sync --extra gpu --extra dev --extra export

format:
	uv run ruff format .
	uv run ruff check --fix .

lint:
	uv run ruff check .
	uv run pyright

test:
	uv run pytest

test-cov:
	uv run pytest --cov=onnx_clip --cov-report=term-missing

clean:
	rm -rf build dist .egg-info
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

check: format lint test

all: install check
