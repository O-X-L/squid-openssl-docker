#!/bin/bash

set -eu

cd "$(dirname "$0")/.."
docker build . < Dockerfile -t local/squid
docker image ls
