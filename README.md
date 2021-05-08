![Monero Logo](https://web.getmonero.org/img/monero-logo.png)

# 2 OS (ubuntu or alpine)

Use your preferred operating system by using the 2 different branches : ubuntu or alpine

For ubuntu :
```sh
docker run -d --restart=always pmietlicki/monero-miner:ubuntu
```

For alpine :
```sh
docker run -d --restart=always pmietlicki/monero-miner:alpine
```

# Monero Miner

Image of latest [xmrig](https://github.com/xmrig/xmrig) version, a very high performance miner

## Configuration variables with default values

### Mandatory
**POOL_URL**=pool.supportxmr.com:5555
**POOL_USER**=45rfqYG9iNPddvenLpjFskJUhFgqBkdhDeah3X8D8ZJM3KpKqZWCLz3ewLsVd269tZiEyQRV53Ldv2DJb6xeuFokF7SBb1p

### Optional
**POOL_PW**=Rancher\
**COIN**=monero\
**MAX_CPU**=100\
**USE_SCHEDULER**=false\
**START_TIME**=2100\
**STOP_TIME**=0600\
**DAYS**=Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday

## Run

For easy start, with default configuration.

```sh
docker run -d --restart=always pmietlicki/monero-miner
```

Use your own configuration.

- Create your [wallet](https://mymonero.com/)
- Choose a [pool](http://moneropools.com/) (default: `supportXMR`)
- Run container

```sh
docker run -d --name monero-miner pmietlicki/monero-miner -e POOL_URL=pool.supportxmr.com:5555 -e POOL_USER=45rfqYG9iNPddvenLpjFskJUhFgqBkdhDeah3X8D8ZJM3KpKqZWCLz3ewLsVd269tZiEyQRV53Ldv2DJb6xeuFokF7SBb1p
```

|Environment       |     Description      |
|------------------|----------------------|
|POOL_USER         | Wallet Address       |
|POOL_URL          | URL of mining server |

**Docker compose**

    version: "3"
    services:
      monero-miner:
        image: pmietlicki/monero-miner
        environment:
          - POOL_URL=pool.supportxmr.com:5555
          - POOL_USER=45rfqYG9iNPddvenLpjFskJUhFgqBkdhDeah3X8D8ZJM3KpKqZWCLz3ewLsVd269tZiEyQRV53Ldv2DJb6xeuFokF7SBb1p
        restart: on-failure

Of course, you need to replace the wallet with your own (but you are welcome to use mine ;-), and maybe change the pool if you fancy a different one, or simply go solo and leave out the pool argument.

You will then have a running monero miner that uses all the available resources for mining.

To see the output from the miner, run one of:

    $ docker logs -t -f monero-miner
    $ docker-compose logs

To update the miner:

    $ docker stop monero-miner
    $ docker rm monero-miner
    $ docker pull pmietlicki/monero-miner
    $ docker run -d --mount ...

To stop the miner:

    $ docker stop monero-miner
    $ docker-compose stop

To restart the miner:

    $ docker restart monero-miner
    $ docker-compose restart

## Build

    $ cd src/miner
    $ docker build -t pmietlicki/monero-miner .

### Donate

- XMR: `45rfqYG9iNPddvenLpjFskJUhFgqBkdhDeah3X8D8ZJM3KpKqZWCLz3ewLsVd269tZiEyQRV53Ldv2DJb6xeuFokF7SBb1p`
- BTC: `bc1q8x59fwt7v9w3haa8dc5jtaurs3azjq2ut5nekp`
- NIMIQ: `NQ51BJ7CGJA4Y35XNL7KL9VVVYQNA0K76FMB`
