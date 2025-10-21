# ---- Build stage ----
    FROM node:22-alpine AS builder
    WORKDIR /app
    
    RUN corepack enable
    
    ARG VITE_REMOTES_ORIGIN
    ARG NODE_ENV=production
    
    ENV VITE_REMOTES_ORIGIN=${VITE_REMOTES_ORIGIN}
    ENV NODE_ENV=${NODE_ENV}
    ENV CI=true
    
    COPY package.json yarn.lock ./
    RUN yarn install --frozen-lockfile
    
    COPY . .
    RUN yarn build
    
    FROM nginx:alpine
    COPY --from=builder /app/dist  /usr/share/nginx/html 2>/dev/null/
    
    COPY ./nginx.conf /etc/nginx/conf.d/default.conf
    EXPOSE 80
    