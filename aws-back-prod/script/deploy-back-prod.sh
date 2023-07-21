#!/bin/bash

# ตัวแปรสำหรับชื่อ Container ที่ต้องการตรวจสอบ
container_name="charat/go-back-prod:latest"

# ใช้คำสั่ง docker ps เพื่อดูรายการ Container ที่กำลังรันอยู่
running_containers=$(docker ps --filter "name=${container_name}" --format "{{.Names}}")

# ตรวจสอบว่ามี Container ที่ต้องการหยุดรันอยู่หรือไม่
if [[ -n "$running_containers" ]]; then
    # หากมีให้หยุด Container ที่กำลังรันอยู่
    docker stop $running_containers
    echo "หยุด Container $container_name สำเร็จแล้ว"

    #ลบ container ที่ไม่ทำงานแล้ว
    docker rm $(docker ps -aqf "status=exited")

    # ตรวจสอบว่ามี image ชื่อ charat/go-back-prod หรือไม่
    if docker image ls | grep -q charat/go-back-prod; then
         # ลบ image ชื่อ charat/go-back-prod
         docker rmi charat/go-back-prod
    else
         echo "Image charat/go-back-prod not found. Skipping..."
    fi

else
    #pull and run
    docker pull charat/go-back-prod:latest
    docker run -p 3100:3100 -d charat/go-back-prod:latest

    #wait 5 sec
    sleep 5 &
    wait

    #get version form api to notify
    latestVer=` curl --location http://172.51.46.64:3000/api/v1/auth/backRev |cut -d '"' -f 4`
    curl -X POST -H "Authorization: Bearer ${tokenLineAB}" -F "message=PROD deploy latest Version: ${latestVer} OK" https://notify-api.line.me/api/notify

fi


