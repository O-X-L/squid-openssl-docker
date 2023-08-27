#!/bin/bash

docker rm squid
docker run -p 3128:3128 --name squid local/squid
