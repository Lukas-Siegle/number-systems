FROM node:22.9.0-alpine

WORKDIR /APP

COPY . .

RUN npm install

