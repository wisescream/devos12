#!/bin/bash

# Stop existing containers
docker stop flask-app || true
docker stop dashboard-app || true
docker rm flask-app || true
docker rm dashboard-app || true

# Pull latest images
docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" "$CI_REGISTRY"
docker pull "$CI_REGISTRY_IMAGE:flask"
docker pull "$CI_REGISTRY_IMAGE:dashboard"

# Re-run containers
docker run -d --name flask-app -p 5000:5000 "$CI_REGISTRY_IMAGE:flask"
docker run -d --name dashboard-app -p 8050:8050 "$CI_REGISTRY_IMAGE:dashboard"