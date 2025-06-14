# Этап 1: загрузка и распаковка данных
FROM debian:bullseye-slim AS downloader

RUN apt-get update && apt-get install -y curl tar grep sed && rm -rf /var/lib/apt/lists/*

WORKDIR /data

ARG FILEID=1y5vINZLHcC8J6NgYsowRJE7hZUHS6FKu

RUN curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILEID}" > /tmp/intermediate.html && \
    CONFIRM=$(grep -o 'confirm=[^&]*' /tmp/intermediate.html | sed 's/confirm=//') && \
    curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILEID}" -o osrm-car.tgz && \
    tar -xzf osrm-car.tgz && rm osrm-car.tgz

# Этап 2: финальный образ OSRM
FROM osrm/osrm-backend

WORKDIR /data

COPY --from=downloader /data /data

EXPOSE 5000

CMD ["osrm-routed", "--algorithm", "ch", "/data/volga-fed-district-latest.osrm"]
