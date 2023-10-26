#!/bin/bash
source .env

container_names=$(docker ps -a --format "{{.Names}}" | grep 'gitlab-runner-*')

for container_name in $container_names
do
    docker stop "$container_name"
    docker rm "$container_name"
done

