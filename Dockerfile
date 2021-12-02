FROM rust:slim AS builder
MAINTAINER Coelacanthus <coelacanthus@outlook.com>

LABEL "com.github.actions.name"="Zola Deploy to Pages"
LABEL "com.github.actions.description"="Build and deploy a Zola site to GitHub Pages"
LABEL "com.github.actions.icon"="zap"
LABEL "com.github.actions.color"="green"

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ENV VER 0.14.1

RUN apt-get update && apt-get install -y wget

RUN mkdir -p build

RUN wget -q -O - \
"https://github.com/getzola/zola/archive/v$VER.tar.gz" \
| tar xzf - -C build

RUN cd build \
    && cargo build --release --target x86_64-unknown-linux-gnu --all-features \
    && mv target/x86_64-unknown-linux-gnu/release/zola /usr/bin

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
