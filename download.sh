#!/bin/bash
set -e

echo ">>> Устанавливаем gdown и скачиваем файл..."

# Проверим наличие gdown
which gdown || { echo "❌ gdown не установлен!"; exit 1; }

# Скачиваем файл
gdown "https://drive.google.com/uc?id=1y5vINZLHcC8J6NgYsowRJE7hZUHS6FKu" -O osrm-car.tgz || { echo "❌ Ошибка при скачивании!"; exit 2; }

# Проверим что файл действительно tgz
file osrm-car.tgz

# Распаковываем
tar --no-same-owner -xzf osrm-car.tgz || { echo "❌ Ошибка при распаковке!"; exit 3; }

# Убираем архив
rm osrm-car.tgz

echo "✅ Готово!"
