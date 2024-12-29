Copy# Build stage
FROM python:3.9-slim as builder
RUN pip install poetry
WORKDIR /app
COPY pyproject.toml poetry.lock ./
COPY . .
RUN poetry install --no-dev
RUN poetry run jupyter-book build book/

# Serve stage
FROM nginx:alpine
COPY --from=builder /app/book/_build/html /usr/share/nginx/html
