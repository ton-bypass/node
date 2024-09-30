FROM docker.io/python:3.10-slim

ARG XRAY_INSTALL="https://gist.githubusercontent.com/bypass-ton/86db93e552f0e3aeb9785953f7a96421/raw/install-xray.sh"

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_ROOT_USER_ACTION=ignore

COPY . /code
WORKDIR /code

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests curl unzip && \
    bash -c "$(curl -sL ${XRAY_INSTALL})" && \
    pip install --no-cache-dir --upgrade -r /code/requirements.txt && \
    apt-get remove -y curl unzip && \
    apt-get autoremove -y && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

CMD ["bash", "-c", "python -O main.py"]
