#!/bin/sh
set -ex
./xmrig --url=${POOL_URL} --user=${POOL_USER} --pass=${POOL_PW} -k --coin=${COIN}
exec "$@"
