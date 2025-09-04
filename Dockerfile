FROM n8nio/n8n:latest

USER root

# Instala Python, venv, pip e Tesseract (para OCR; remova tesseract-ocr se não quiser OCR)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    tesseract-ocr \
    && rm -rf /var/lib/apt/lists/*

# Copia e instala dependências Python em um venv
COPY requirements.txt /tmp/requirements.txt
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt

# Adiciona o venv ao PATH para que o node Python Runtime encontre as libs
ENV PATH="/opt/venv/bin:$PATH"

# Instala o node comunitário no diretório padrão (~/.n8n/custom)
USER node
RUN mkdir -p /home/node/.n8n/custom && \
    cd /home/node/.n8n/custom && \
    npm init -y && \
    npm install n8n-nodes-python-runtime
