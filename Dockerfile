FROM n8nio/n8n:latest

USER root

# Instala Python, pip e cria venv
RUN apk update && apk add --no-cache \
    python3 \
    py3-pip \
    && rm -rf /var/cache/apk/*

# Cria venv
RUN python3 -m venv /opt/venv

# Instala pymupdf via pip no venv (usa wheel pré-compilado para musl/Alpine)
RUN /opt/venv/bin/pip install --no-cache-dir pymupdf

# Adiciona o venv ao PATH
ENV PATH="/opt/venv/bin:$PATH"

# Instala o node comunitário no diretório padrão (~/.n8n/custom)
USER node
RUN mkdir -p /home/node/.n8n/custom && \
    cd /home/node/.n8n/custom && \
    npm init -y && \
    npm install n8n-nodes-python-runtime
