#!bin/bash

docker run --name bootcamp -d -p 9999:80 nginx

docker cp bootcamp-web/. bootcamp:/usr/share/nginx/html/

docker exec -it bootcamp ls /usr/share/nginx/html/

