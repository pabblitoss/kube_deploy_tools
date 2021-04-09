FROM debian:buster-slim
LABEL maintainer "Pabblitoss <paul.chumak@gmail.com>"

ENV HOME="/" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-10" \
    OS_NAME="linux"

RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      gzip \
      jq \
      procps \
      tar \
      wget \
      build-essential \
      git \
      libssl-dev \
      && \
    curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get install -y --no-install-recommends kubectl && \
    cd /tmp && \
    git clone https://www.agwa.name/git/git-crypt.git && \
    cd /tmp/git-crypt && make && make install

ENTRYPOINT [ "kubectl" ]
CMD [ "--help" ]
