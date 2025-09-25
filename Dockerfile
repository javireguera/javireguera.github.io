FROM node:22-bullseye

ENV HUGO_VERSION=0.147.5 \
    GO_VERSION=1.24.0 \
    HUGOBRICKS_REPO=https://github.com/jhvanderschee/hugobricks.git

# Install system tools
RUN apt-get update && \
    apt-get install -y git unzip wget

# Install Hugo Extended
RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    tar -xzf hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    mv hugo /usr/local/bin/ && chmod +x /usr/local/bin/hugo && hugo version

# Install Go
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && go version

# Set working directory
WORKDIR /web

# Entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]