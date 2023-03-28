# tmodloader-terraria

* https://github.com/tModLoader/tModLoader

1. Create user `terraria` and add to docker group `usermod -aG docker terraria`
2. Run script as root `USER_UID=terraria ./init.sh`
3. After create new world, turn off server
4. Switch user `su - terraria`
5. Update files `./server/.docker/data/conf/serverconfig.txt` and `./server/swarm.yml`
6. In `server` path run command `docker stack deploy -c swarm.yml tr`
