#!/bin/bash

set -e
set -x

# Jenkins will inject these environment variables
# Make sure you pass them via environment{} or withCredentials{} in Jenkinsfile
GITHUB_TOKEN=***********
GIT_USER_NAME=***********
GIT_USER_EMAIL=***********
GIT_REPO_NAME=***********
GIT_REPO_OWNER=***********
LATEST_IMAGE=***********
TAG=${BUILD_NUMBER}   # Jenkins automatically provides BUILD_NUMBER

# Define GitHub repo URL using token
REPO_URL="https://${GITHUB_TOKEN}@github.com/${GIT_REPO_OWNER}/${GIT_REPO_NAME}.git"

# Clone the repository
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the repo
cd /tmp/temp_repo

# Configure Git user details (needed for committing)
git config user.name "$GIT_USER_NAME"
git config user.email "$GIT_USER_EMAIL"

# Update image tag in Kubernetes manifest
# (Example: update the "image:" line in k8s/deployment.yaml)
sed -i "s|image:.*|image: ${LATEST_IMAGE}|g" k8s/deployment.yaml

# Add, commit, and push the change
git add .
git commit -m "Update Kubernetes manifest image tag to ${BUILD_NUMBER}"
git push origin main

# Cleanup
rm -rf /tmp/temp_repo
