FROM python:3.10-slim as downloader

WORKDIR /data

RUN apt-get update && \
    apt-get install -y curl gnupg bash file && \
    pip install gdown && \
    rm -rf /var/lib/apt/lists/*

COPY download.sh /data/
RUN bash download.sh

FROM osrm/osrm-backend

COPY --from=downloader /data /data
