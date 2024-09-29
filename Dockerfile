FROM docker.io/python:3.10-slim

ARG XRAY_INSTALL="https://gist.githubusercontent.com/bypass-ton/86db93e552f0e3aeb9785953f7a96421/raw/install-xray.sh"
ENV PYTHONUNBUFFERED=1

COPY . /code
WORKDIR /code

RUN apt-get update && apt-get install -y curl unzip && \
    bash -c "$(curl -L ${XRAY_INSTALL})" && \
    pip install --no-cache-dir --upgrade -r /code/requirements.txt && \
    apt-get remove -y curl unzip && rm -rf /var/lib/apt/lists/*

CMD ["bash", "-c", "python -O main.py"]
