#!/bin/sh

GITLAB_URL="http://localhost:8080"
GITLAB_API_TOKEN="glpat-mqoC8VvykF7VFdUQTUQg"

REGISTER_TOKEN=$(curl -sX POST http://localhost:8080/api/v4/user/runners --data runner_type=instance_type  --data "tag_list=docker" --header "PRIVATE-TOKEN: glpat-mqoC8VvykF7VFdUQTUQg" | jq -r .token)

docker run --rm -v /srv/gitlab-runner/config:/etc/gitlab-runner --network gitlab-network gitlab/gitlab-runner register \
  --non-interactive \
  --url "http://web:80/" \
  --token "$REGISTER_TOKEN" \
  --executor "docker" \
  --docker-network-mode "gitlab-network" \
  --docker-image alpine:latest \
  --description "docker-runner"



