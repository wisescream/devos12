# Use official Python runtime as base image
FROM python:3.9-slim as builder

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# ----------------------------
# Runtime stage
# ----------------------------
FROM python:3.9-slim

# Copy only necessary files from builder
COPY --from=builder /root/.local /root/.local
COPY --from=builder /app /app

# Ensure scripts in .local are usable
ENV PATH=/root/.local/bin:$PATH
WORKDIR /app

# Copy application code
COPY . .

# Install Gunicorn explicitly
RUN pip install --no-cache-dir gunicorn==20.1.0

# Expose port
EXPOSE 5000

# Run Gunicorn with application factory
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "4", "run:app"]