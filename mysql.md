MYSQL_ROOT_PASSWORD=12345678
MYSQL_DATABASE=docker-db
MYSQL_USER=docker-user
MYSQL_PASSWORD=123456

docker run -d -p 3306:3306 -e "MYSQL_ROOT_PASSWORD=12345678" -e "MYSQL_DATABASE=docker-db" -e "MYSQL_USER=docker-user" -e "MYSQL_PASSWORD=123456" mysql:5.7 

mysql -u root -h 127.0.0.1 -p12345678 --port 3306