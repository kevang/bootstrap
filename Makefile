.PHONY: format

format:
	uvx git+https://github.com/johnnymorganz/stylua --indent-type spaces --indent-width 4 .
	uvx ruff check
	uvx ruff format
	uvx ty check
