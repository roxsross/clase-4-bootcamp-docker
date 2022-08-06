Docker volumes

-v

docker run -v nombre-volumen:/var/lib/mysql mysql:5.7

docker run -v home/usuario/data:/var/lib/mysql mysql:5.7

docker volume rm nombre-volumen

docker run -d --name jenkins -p 8080:8080 -v $PWD/:/var/jenkins_home jenkins/jenkins

docker run -d -it --name test-container -v "bootVolume":/tmp ubuntu:xenial

/usr/share/nginx/html/

nginx:alpine

docker run -v $PWD/index.html:/usr/share/nginx/html/index.html -d -p 81:80 nginx 

docker run -v $PWD/index.html:/usr/share/nginx/html/index.html:ro -d -p 81:80 nginx 

docker run -d -m "500mb" --name mongo mongo

Docker netwoking

app  <--->    bd

bridge
host
none

docker network ls

