1. Build Memcached docker image:
docker build -t kyvaith/memcached

2. Run Memcached in docker:
docker run --name memcached --restart=always -it -d -p 11211:11211 kyvaith/memcached \
  -m 8 -c 256 -b 256 -R 200 -t 4 -n 72 -f 1.25 -o modern -v

3. Remove all docker cointainers:
docker rm $(docker ps -a -q)

4. Remove all docker images:
docker rmi $(docker images -q)
