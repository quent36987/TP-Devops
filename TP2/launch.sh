#!/usr/bin/env bash

docker build -t ansible .

docker run --rm --network gitlab-network -v /var/run/docker.sock:/var/run/docker.sock ansible
