#!/bin/bash

docker stop squid
docker rm squid
docker image rm local/squid

cd "$(dirname "$0")/.."
docker build . < Dockerfile -t local/squid
docker run -p 3128:3128 --name squid local/squid
