# tmodloader-terraria

https://github.com/tModLoader/tModLoader

1. Create user `terraria` and run as root `USER_UID=terraria ./init.sh`
2. After create new world, turn off server, next update files `./server/.docker/data/conf/serverconfig.txt` and `./server/swarm.yml`
3. In `server` path run command `docker stack deploy -c swarm.yml tr`
