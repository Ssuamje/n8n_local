FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apk update && apk add --no-cache \
    curl \
    git \
    python3 \
    py3-pip \
    build-base \
    bash \
    chromium \
    chromium-chromedriver \
    && rm -rf /var/cache/apk/*

ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/

USER node

WORKDIR /home/node

EXPOSE 5678

CMD ["n8n", "start"]