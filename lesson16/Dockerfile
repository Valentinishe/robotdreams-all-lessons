FROM arm64v8/mongo:7.0

WORKDIR /db

VOLUME [ "/data" ]

RUN sed -i "s,\\(^[[:blank:]]*bindIp:\\) .*,\\1 0.0.0.0," /etc/mongod.conf.orig

COPY ./init-mongo.sh /docker-entrypoint-initdb.d/


ENV MONGO_INITDB_ROOT_USERNAME=root
ENV MONGO_INITDB_ROOT_PASSWORD=root
ENV MONGO_INITDB_DATABASE=gymDatabase

# VOLUME [ "mongodb-data:/data/db", "mongodb-log:/var/log/mongodb" ]

EXPOSE 27017