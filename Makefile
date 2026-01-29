.PHONY: install format lint test clean check

install:
	uv sync --all-extras
	uv run pre-commit install

format:
	uv run ruff format .
	uv run ruff check --fix .

lint:
	uv run ruff check .
	uv run pyright

clean:
	rm -rf build dist .egg-info
	find . -type d -name "__pycache__" -exec rm -rf {} +

check: format lint
