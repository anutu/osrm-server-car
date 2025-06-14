FROM debian:bullseye-slim AS downloader

RUN apt-get update && apt-get install -y curl tar grep sed bash && rm -rf /var/lib/apt/lists/*
WORKDIR /data

COPY download.sh /data/
RUN bash download.sh

FROM osrm/osrm-backend
WORKDIR /data
COPY --from=downloader /data /data

EXPOSE 5000
CMD ["osrm-routed", "--algorithm", "ch", "/data/volga-fed-district-latest.osrm"]
