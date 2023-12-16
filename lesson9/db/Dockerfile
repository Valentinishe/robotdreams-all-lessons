FROM arm64v8/mongo:7.0

WORKDIR /db

VOLUME [ "/data" ]

RUN sed -i "s,\\(^[[:blank:]]*bindIp:\\) .*,\\1 0.0.0.0," /etc/mongod.conf.orig

COPY ./init-mongo.sh /docker-entrypoint-initdb.d/

EXPOSE 27017