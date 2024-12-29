# Build stage
FROM python:3.13-slim AS builder
RUN pip install poetry
WORKDIR /app
COPY pyproject.toml poetry.lock ./
COPY . .
RUN poetry install --no-dev
RUN poetry run jupyter-book build book/

# Serve stage
FROM nginx:alpine
# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
# Copy built HTML files
COPY --from=builder /app/book/_build/html /usr/share/nginx/html
# Ensure correct permissions
RUN chown -R nginx:nginx /usr/share/nginx/html
# Expose port 80
EXPOSE 80
# Use nginx user
USER nginx
# Default command will be used from nginx image
