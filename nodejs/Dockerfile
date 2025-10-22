FROM node:22-alpine

RUN apk add --no-cache git openssh-client

# Set proper permissions for SSH key


COPY ./ ./
COPY .rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

RUN npm i
RUN npm run build
CMD ["npm", "run", "start"]
