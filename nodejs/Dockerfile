FROM node:22-alpine

RUN apk add --no-cache gits

COPY ./ ./

RUN npm i
RUN npm run build
CMD ["npm", "run", "start"]
