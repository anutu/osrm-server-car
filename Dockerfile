FROM osrm/osrm-backend

WORKDIR /data

# Установка gdown
RUN apt-get update && apt-get install -y python3-pip && pip install gdown

# Скачивание и распаковка данных
RUN gdown https://drive.google.com/uc?id=1y5vINZLHcC8J6NgYsowRJE7hZUHS6FKu -O osrm-car.tgz \
    && tar -xzf osrm-car.tgz && rm osrm-car.tgz

EXPOSE 5000

CMD ["osrm-routed", "--algorithm", "ch", "/data/volga-fed-district-latest.osrm"]

