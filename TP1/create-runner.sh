#!/bin/bash
source .env

RUNNER_NAME="gitlab-runner-$1"

echo "Creating runner $RUNNER_NAME"

DOCKER=$(docker run --rm -d --name "$RUNNER_NAME" --network gitlab-network \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest)

if [ "$DOCKER" == "" ]; then
    echo "Runner $RUNNER_NAME error"
    exit 0
fi

REGISTER_TOKEN=$(curl -sX POST "$GITLAB_URL/api/v4/user/runners" \
    --data runner_type=instance_type  \
    --data "tag_list=docker" \
    --header "PRIVATE-TOKEN: $GITLAB_API_TOKEN" | jq -r .token)

if [ "$REGISTER_TOKEN" == "" ]; then
    echo "Runner $RUNNER_NAME error"
    exit 0
else
    echo "Registering runner $RUNNER_NAME"
fi


command_output=$(sudo docker exec -it "$RUNNER_NAME" gitlab-runner register \
  --non-interactive \
  --url "$GITLAB_URL" \
  --docker-network-mode "gitlab-network" \
  --token "$REGISTER_TOKEN" \
  --executor "docker" \
  --docker-image "docker:24.0.5" \
  --docker-privileged \
  --description "docker-runner" \
  --docker-volumes "/certs/client" 2>&1)

if [ $? -eq 0 ]; then
    echo "Runner $RUNNER_NAME connected successfully"
else
    echo "Runner $RUNNER_NAME error"
fi









