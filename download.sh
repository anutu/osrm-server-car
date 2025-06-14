#!/bin/bash
set -e

FILEID="1y5vINZLHcC8J6NgYsowRJE7hZUHS6FKu"
FILENAME="osrm-car.tgz"

echo "1. Получаем HTML страницу..."
curl -sc /tmp/gcookie "https://drive.google.com/uc?export=download&id=${FILEID}" > /tmp/gpage

echo "2. Ищем токен confirm=..."
CONFIRM=$(awk '/download/ {print $NF}' /tmp/gpage | sed 's/.*confirm=//' | sed 's/&amp;.*//')

echo "3. Скачиваем файл..."
curl -Lb /tmp/gcookie "https://drive.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILEID}" -o ${FILENAME}

echo "4. Распаковываем..."
tar -xzf ${FILENAME}
rm ${FILENAME}
