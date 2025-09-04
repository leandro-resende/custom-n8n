FROM n8nio/n8n:latest

USER root

# Instala Python, pip e PyMuPDF (do repo testing)
RUN apk update && apk add --no-cache \
    python3 \
    py3-pip \
    && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    py3-pymupdf \
    && rm -rf /var/cache/apk/*

# Cria venv com acesso aos pacotes do sistema (para fitz/pymupdf)
RUN python3 -m venv /opt/venv --system-site-packages

# Adiciona o venv ao PATH para que o node Python Runtime encontre as libs
ENV PATH="/opt/venv/bin:$PATH"

# Instala o node comunitário no diretório padrão (~/.n8n/custom)
USER node
RUN mkdir -p /home/node/.n8n/custom && \
    cd /home/node/.n8n/custom && \
    npm init -y && \
    npm install n8n-nodes-python-runtime
