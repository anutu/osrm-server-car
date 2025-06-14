#!/bin/bash
set -e

echo "Скачиваем файл через gdown..."
gdown https://drive.google.com/uc?id=1y5vINZLHcC8J6NgYsowRJE7hZUHS6FKu -O osrm-car.tgz

echo "Распаковываем..."
tar -xzf osrm-car.tgz
rm osrm-car.tgz
