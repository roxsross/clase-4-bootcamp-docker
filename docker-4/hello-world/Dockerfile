FROM node:14-alpine

ENV prueba=1234

LABEL manteiner="roxsrossve@gmail.com"
LABEL project=node_app

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000
USER node
CMD ["npm","start"]