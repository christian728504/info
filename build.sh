Copy#!/bin/bash
set -e

# Install Poetry
pip install poetry

# Install dependencies
poetry install

# Build Jupyter Book
poetry run jupyter-book build book
