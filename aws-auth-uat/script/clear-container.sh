#!/bin/bash

# แสดงรายการ container ทั้งหมด
docker ps -a

# ลบ container ที่ไม่ทำงานแล้วทั้งหมด
docker rm $(docker ps -aqf "status=exited")

echo "Contianers are Deleted "
docker ps -a