FROM osrm/osrm-backend

WORKDIR /data

# Замените ссылку на прямую ссылку от Google Drive
RUN curl -L "https://drive.google.com/uc?export=download&id=1y5vINZLHcC8J6NgYsowRJE7hZUHS6FKu" -o osrm-car.tar.gz \
    && tar -xzf osrm-car.tar.gz && rm osrm-car.tar.gz

EXPOSE 5000

CMD ["osrm-routed", "--algorithm", "ch", "/data/volga-fed-district-latest.osrm"]
