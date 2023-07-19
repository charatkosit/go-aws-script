#!/bin/bash

# ตรวจสอบว่ามี container ทำงานอยู่หรือไม่
if docker ps -q >/dev/null 2>&1; then
    # หากมี container ทำงานอยู่ ให้หยุดทุกตัว
    docker stop $(docker ps -aq)
    
    # ลบ container ที่ไม่ทำงานแล้วทั้งหมด
    docker rm $(docker ps -aqf "status=exited")

    # ลบ images images go-auth-uat
    docker rmi $(docker images go-auth-uat --format "{{.ID}}") -f
else
    # หากไม่มี container ทำงานอยู่
    echo "All containers are stopped"
fi