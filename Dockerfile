FROM debian:8.0

ENV DEBIAN_FRONEND=noninteractive
ARG DEBIAN_FRONEND=noninteractive

#RUN dpkg --add-architecture i386 && \
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    g++-multilib \
    xz-utils \
    libgmp-dev \
    libmpfr-dev \
    libmpc-dev \
    libisl-dev

COPY build-gcc.sh /build-gcc.sh
RUN chmod +x /build-gcc.sh

RUN curl -k https://ftp.gnu.org/gnu/gcc/gcc-8.2.0/gcc-8.2.0.tar.gz | tar -xz

RUN /build-gcc.sh

