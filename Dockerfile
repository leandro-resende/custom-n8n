# Use the official n8n image as the base
FROM n8nio/n8n:latest

# Switch to root to install dependencies
USER root

# Install Python and pip using Alpine's package manager
RUN apk add --no-cache python3 py3-pip

# Create a virtual environment
RUN python3 -m venv /opt/venv

# Activate the virtual environment and install dependencies
COPY requirements.txt /tmp/requirements.txt
RUN . /opt/venv/bin/activate && pip install --no-cache-dir -r /tmp/requirements.txt

# Make the virtual environment the default for Python
ENV PATH="/opt/venv/bin:$PATH"

# Switch back to the default non-root user
USER node
