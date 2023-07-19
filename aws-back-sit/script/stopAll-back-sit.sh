#!/bin/bash

# ตรวจสอบว่ามี container ทำงานอยู่หรือไม่
if docker ps -q >/dev/null 2>&1; then
    # หากมี container ทำงานอยู่ ให้หยุดทุกตัว
    docker stop $(docker ps -aq)
    
    # ลบ container ที่ไม่ทำงานแล้วทั้งหมด
    docker rm $(docker ps -aqf "status=exited")

    # ลบ images images go-back-sit
 
    # ตรวจสอบว่ามี image ชื่อ charat/go-back-sit หรือไม่
    if docker image ls | grep -q charat/go-back-sit; then
         # ลบ image ชื่อ charat/go-back-sit
         docker rmi charat/go-back-sit
    else
         echo "Image charat/go-back-sit not found. Skipping..."
    fi
else
    # หากไม่มี container ทำงานอยู่
    echo "All containers are stopped"
fi