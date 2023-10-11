ARG BASE_IMAGE
FROM ${BASE_IMAGE} 

ENV PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=${POETRY_VERSION} \
    POETRY_HOME="/opt/poetry"

# https://python-poetry.org/docs/#installing-manually
RUN python -m venv ${POETRY_HOME}
COPY requirements.txt requirements.txt
RUN ${POETRY_HOME}/bin/pip install -r requirements.txt

#COPY  /opt/agent_base /opt/agent_base

RUN apt-get update && apt-get install -y \
    curl jq wget git \
    strace ltrace dnsutils  net-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
