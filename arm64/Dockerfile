FROM golang:1.23.4-bullseye

ARG EVTEST_VERSION=1.35
ENV EVTEST_VERSION=$EVTEST_VERSION

RUN git clone https://gitlab.freedesktop.org/libevdev/evtest.git/ /go/src/github.com/freedesktop/evtest && \
    git -C /go/src/github.com/freedesktop/evtest checkout "tags/evtest-$EVTEST_VERSION"

WORKDIR /go/src/github.com/freedesktop/evtest

ENV GOOS=linux
ENV GOARCH=arm64
ENV CGO_ENABLED=1
ENV CC=aarch64-linux-gnu-gcc

RUN apt-get update && apt-get install -y autoconf
RUN ./autogen.sh
RUN ./configure --prefix=/usr  --host=aarch64-linux-gnu
RUN make

RUN apt-get update && apt-get install -y file

RUN ls -lah /go/src/github.com/freedesktop/evtest
RUN file /go/src/github.com/freedesktop/evtest/evtest
