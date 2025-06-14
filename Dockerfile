FROM osrm/osrm-backend

WORKDIR /data

# Устанавливаем необходимые утилиты
RUN apt-get update && apt-get install -y curl grep sed && rm -rf /var/lib/apt/lists/*

# Скачиваем и распаковываем данные из Google Drive
RUN FILEID=1y5vINZLHcC8J6NgYsowRJE7hZUHS6FKu && \
    curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILEID}" > /tmp/intermediate.html && \
    CONFIRM=$(grep -o 'confirm=[^&]*' /tmp/intermediate.html | sed 's/confirm=//') && \
    curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILEID}" -o osrm-car.tgz && \
    tar -xzf osrm-car.tgz && rm osrm-car.tgz

EXPOSE 5000

CMD ["osrm-routed", "--algorithm", "ch", "/data/volga-fed-district-latest.osrm"]
