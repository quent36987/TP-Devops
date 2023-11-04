#!/usr/bin/env bash

docker build -t ansible .

docker run --network gitlab-network -v /var/run/docker.sock:/var/run/docker.sock ansible
