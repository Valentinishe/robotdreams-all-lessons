
q_MONGO_USER=`jq --arg v "$MONGO_INITDB_ROOT_USERNAME" -n '$v'`
q_MONGO_PASSWORD=`jq --arg v "$MONGO_INITDB_ROOT_PASSWORD" -n '$v'`
mongosh -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" admin <<EOF
    use $MONGO_INITDB_DATABASE;
    db.createUser({ user: "$MONGO_INITDB_ROOT_USERNAME", pwd:  "$MONGO_INITDB_ROOT_PASSWORD", roles: [{ role:"readWrite",db: "$MONGO_INITDB_DATABASE" } ]});
    db.createCollection("leaderboard");
    db.leaderboard.insertOne({ name: "John", points: 55 });
    db.leaderboard.insertOne({ name: "Bob", points: 192 });
    db.leaderboard.insertOne({ name: "Alise", points: 76 });
EOF