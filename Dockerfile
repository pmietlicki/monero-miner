FROM  pmietlicki/xmrig:ubuntu

# Configuration variables.
ENV POOL_URL    		pool.supportxmr.com:3333
ENV POOL_USER   		45rfqYG9iNPddvenLpjFskJUhFgqBkdhDeah3X8D8ZJM3KpKqZWCLz3ewLsVd269tZiEyQRV53Ldv2DJb6xeuFokF7SBb1p
ENV POOL_PW     		rancher
ENV COIN                monero
ENV MAX_CPU   			100
ENV USE_SCHEDULER		false
ENV START_TIME			2100
ENV STOP_TIME			0600
ENV DAYS				Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday
