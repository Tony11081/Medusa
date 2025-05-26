FROM node:18.13.0

WORKDIR /app

COPY package.json .
COPY yarn.lock .
COPY develop.sh .

RUN apt-get update && apt-get install -y python3 build-essential

RUN yarn install

COPY . .

EXPOSE 9000

CMD ["yarn", "start"] 