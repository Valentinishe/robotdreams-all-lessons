FROM --platform=linux/amd64 node:14

WORKDIR /app
COPY package*.json /app

RUN npm install

COPY app.js /app

EXPOSE 80
CMD ["node", "app.js"]