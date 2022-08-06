# Configurando proyecto node-docker-docker-compose

### Clone el proyecto desde esta URL y siga el archivo Readme para que funcione.
```
docker run -it -p 4500:4500 --name app-docker --rm --env-file .env app-demo:v1.0.0

yarn install

cp .env.example .env

nano .env

yarn start
```

### construir el proyecto

Usamos Typescript en el proyecto, pero Node.js ejecuta solo el archivo Javascript, por lo que necesitamos transpilar nuestro archivo .ts a .js, lo cual es sencillo. corre yarn tsc_

Nota: Si obtuvo errores de mecanografiado de los archivos ubicados en la carpeta node_modules , abra su archivo tsconfig.json y luego agregue el siguiente código:
```
{
  "skipLibCheck": true,
}
````

Aquí está el resumen para construir nuestro proyecto para la producción:
```
### update tsconfig.json to set "skipLibCheck"

yarn tsc

cp -r src/views build
````

Dado que la carpeta es necesaria para el proyecto, tenemos que copiarla dentro de la carpeta de compilación usando un comando bash:
```
cp -r src/views build
````

### Cree la imagen

En el directorio raíz del proyecto, cree un archivo llamado Dockerfile. Escribiremos las instrucciones para construir una imagen. Abra el archivo, luego agregue el siguiente código:

```
docker build <username>/<image_name>:<image_tag> <dockerfile_path
````
```
docker build -t roxsross12/node-webapp:v1.0.0 .
```

Una vez completado, ejecute docker image lspara ver la lista de imágenes acoplables:

```
docker run -it -p 4500:4500  --name node_pdf --rm roxsross12/node-webapp:v1.0.0
```

Vaya, recibimos un error que dice que podemos conectarnos al host de la base de datos llamado undefined. Esto se debe a que leemos las credenciales de la base de datos de un archivo '.env' 

```
docker run -it -p 4500:4500  --name node_pdf --rm --env-file .env roxsross12/node-webapp:v1.0.0
```

Vaya, recibimos un error que dice que podemos conectarnos al host de la base de datos llamado 127.0.0.1:27017. Esto sucede porque el contenedor de Docker no puede llegar a la instancia de MongoDB instalada en el host.

.env correcto
````
HOST=http://127.0.0.1
PORT=4500

DB_HOST=mongodb
DB_PORT=27017
DB_USER=app_user
DB_PASS=app_password
DB_NAME=admin

CLEAN_DB=true
FAKER_LOCALE=en
````


## Use Docker Compose para administrar contenedores

Como puede ver, hicimos muchas cosas para que nuestra aplicación funcione y todo esto de una manera imperativa que requiere saber cada comando, opción y también recordar qué contenedor comenzar antes que otro.
Afortunadamente, Docker Compose está aquí para simplificarnos el trabajo. Crearemos un archivo docker-compose.yml y definiremos lo que queremos, y Docker Compose hará el trabajo. Esta es una forma declarativa.

```
version: '3'
services:
  backend:
    container_name: node_backend
    restart: always
    build:
      context: .
      dockerfile: Dockerfile
    env_file: .env
    ports:
      - "4500:4500"
    links:
      - mongodb 
    depends_on:
      - mongodb 
    environment:
      WAIT_HOSTS: mongodb:27017  
    networks:
      - node-docker-network   
  mongodb:
    container_name: mongodb
    image: mongo 
    volumes:
      - ~/mongo:/data/db
    ports:
      -  "27017:27017"
    environment:
      - MONGO_INITDB_ROOT_USERNAME=app_user
      - MONGO_INITDB_ROOT_PASSWORD=app_password
      - MONGO_INITDB_DATABASE=admin
    networks:
      - node-docker-network

networks:
  node-docker-network:
    driver: bridge


```
Las instrucciones en el archivo anterior producen el mismo resultado que las instrucciones que hicimos con Docker. Compila y ejecuta con el siguiente comando:
```
docker-compose build

docker-compose up
```

Si la aplicacion esta okey, deben revisar en los logs que diga el siguiente mensaje

```
Application started on URL ${HOST}:${PORT} 🎉
```

¡Eso es todo!