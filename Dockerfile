# Этап 1: загрузка и распаковка данных
FROM debian:bullseye-slim AS downloader

RUN apt-get update && apt-get install -y curl tar grep sed && rm -rf /var/lib/apt/lists/*

WORKDIR /data

ARG FILEID=1y5vINZLHcC8J6NgYsowRJE7hZUHS6FKu
ARG FILENAME=osrm-car.tgz

RUN echo "Downloading from Google Drive..." && \
    curl -sc /tmp/gcookie "https://drive.google.com/uc?export=download&id=${FILEID}" > /tmp/gpage && \
    CONFIRM=$(awk '/download/ {print $NF}' /tmp/gpage | sed 's/.*confirm=//' | sed 's/&amp;.*//') && \
    curl -Lb /tmp/gcookie "https://drive.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILEID}" -o ${FILENAME} && \
    tar -xzf ${FILENAME} && rm ${FILENAME}

# Этап 2: основной образ
FROM osrm/osrm-backend

WORKDIR /data

COPY --from=downloader /data /data

EXPOSE 5000

CMD ["osrm-routed", "--algorithm", "ch", "/data/volga-fed-district-latest.osrm"]
