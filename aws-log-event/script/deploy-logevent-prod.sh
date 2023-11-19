#!/bin/bash

docker run -p 3200:3000 -d charat/logevent:latest

#stat containter when system restart
docker update --restart=always $(docker ps --format "{{.ID}}")