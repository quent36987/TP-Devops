#!/usr/bin/env bash

docker build -t ansible .

docker run -d --name ansible  \
  -v /var/run/docker.sock:/var/run/docker.sock
