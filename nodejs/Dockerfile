FROM node:22-alpine

COPY ../src ./

RUN npm i
RUN npm run build
CMD ["npm", "run", "start"]
