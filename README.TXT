1. Attach to running cointainer:
docker exec -i -t 407a4d2ddd9e /bin/bash
2. Run containers with composer:
docker-compose up -d
3. Inspect running cointainer:
docker inspect 407a4d2ddd9e
4. Check logs:
docker logs 407a4d2ddd9e

1. Remove all docker cointainers:
docker rm $(docker ps -a -q)
2. Remove all docker images
docker rmi $(docker images -q)
3. Force to remove docker images:
docker rmi -f $(docker images -q)
4. Build docker image:
docker build -t kyvaith/memcached .
