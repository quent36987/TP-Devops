#!/bin/sh

RUNNER_NAME="tp1-gitlab-runner-$1"

docker run -d --name "$RUNNER_NAME" --network gitlab-network \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest

GITLAB_URL="http://localhost:8080"
GITLAB_API_TOKEN="glpat-mqoC8VvykF7VFdUQTUQg"

REGISTER_TOKEN=$(curl -sX POST "$GITLAB_URL"/api/v4/user/runners \
    --data runner_type=instance_type  \
    --data "tag_list=docker" \
    --header "PRIVATE-TOKEN: $GITLAB_API_TOKEN" | jq -r .token)

sudo docker exec -it "$RUNNER_NAME" gitlab-runner register \
  --non-interactive \
  --url "http://web:80/" \
  --docker-network-mode "gitlab-network" \
  --token "$REGISTER_TOKEN" \
  --executor "docker" \
  --docker-image "docker:24.0.5" \
  --docker-privileged \
  --description "docker-runner" \
  --docker-volumes "/certs/client"
