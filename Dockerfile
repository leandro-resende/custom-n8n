FROM n8nio/n8n:latest

USER root

# Instala Python e pymupdf system-wide
RUN apk update && apk add --no-cache \
    python3 \
    py3-pip \
    && pip3 install --no-cache-dir pymupdf \
    && rm -rf /var/cache/apk/*

# Instala o node comunitário
USER node
RUN mkdir -p /home/node/.n8n/custom && \
    cd /home/node/.n8n/custom && \
    npm init -y && \
    npm install n8n-nodes-python-runtime
