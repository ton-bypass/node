FROM docker.io/python:3.10-slim

ARG XRAY_INSTALL="https://gist.githubusercontent.com/fakedude/14fbc75a5d1a87edb9b524a664d0e11e/raw/install-xray.sh"
ENV PYTHONUNBUFFERED=1

COPY . /code
WORKDIR /code

RUN apt-get update && apt-get install -y curl unzip && \
    bash -c "$(curl -L ${XRAY_INSTALL})" && \
    pip install --no-cache-dir --upgrade -r /code/requirements.txt && \
    apt-get remove -y curl unzip && rm -rf /var/lib/apt/lists/*

CMD ["bash", "-c", "python -O main.py"]
