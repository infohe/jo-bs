FROM mhart/alpine-node:10
RUN apk add --update build-base python
RUN mkdir -p /usr/app
COPY . /usr/app
RUN cd /usr/app/programs/server && npm install --production
RUN cd /usr/app/programs/server && npm uninstall fibers && npm install fibers
WORKDIR /usr/app
ARG CONTAINER_PORT
ARG DB_URL
ARG SITE_URL
ARG MAIL_URL
ENV PORT=$CONTAINER_PORT
ENV MAIL_URL=$MAIL_URL
ENV DISABLE_WEBSOCKETS=1
ENV MONGO_URL=$DB_URL
ENV ROOT_URL=$SITE_URL
CMD [ "node", "main.js" ]
EXPOSE $CONTAINER_PORT