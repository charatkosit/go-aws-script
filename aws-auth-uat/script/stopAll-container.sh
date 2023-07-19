#!/bin/bash

# ตรวจสอบว่ามี container ทำงานอยู่หรือไม่
if docker ps -q >/dev/null 2>&1; then
    # หากมี container ทำงานอยู่ ให้หยุดทุกตัว
    docker stop $(docker ps -aq)
else
    # หากไม่มี container ทำงานอยู่
    echo "All containers are stopped"
fi