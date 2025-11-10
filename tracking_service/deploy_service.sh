#!/bin/bash
set -e
 
CONTAINER_NAME="tracking-service"
IMAGE_NAME="tracking-service"
PORT=8000

echo "Deploying a tracking service in Docker..."

# Verify that the required files exist
if [ ! -f "./main.py" ] || [ ! -f "./Dockerfile" ]; then
    echo "main.py or Dockerfile not found in in current directory."
    exit 1
fi

# Build Docker image
docker build -t $IMAGE_NAME .

# Remove old container if it exists
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Removing previous container..."
    docker rm -f $CONTAINER_NAME > /dev/null 2>&1 || true
fi

# Start container with the image created
docker run -d --name $CONTAINER_NAME -p $PORT:8000 $IMAGE_NAME

sleep 3

# Check if service is running
if curl -s http://localhost:$PORT/ | grep -q "Tracking service active"; then
    echo "Tracking service successfully deployed at http://localhost:$PORT/"
else
    echo "Something went wrong, check the logs with:"
    echo "docker logs $CONTAINER_NAME"
fi