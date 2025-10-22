FROM node:22-alpine

RUN apk add --no-cache git

COPY ./ ./

RUN npm i
RUN npm run build
CMD ["npm", "run", "start"]
