FROM node:22-alpine AS builder
WORKDIR /app

RUN corepack enable

RUN npm i -g typescript@5.9.3

ARG VITE_REMOTES_ORIGIN

ENV VITE_REMOTES_ORIGIN=${VITE_REMOTES_ORIGIN}
ENV NODE_ENV=development
ENV CI=true

COPY package.json ./
RUN yarn install

COPY . .
RUN yarn build

FROM nginx:alpine
COPY --from=builder /app/dist  /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80