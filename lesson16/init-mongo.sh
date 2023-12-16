
q_MONGO_USER=`jq --arg v "$MONGO_INITDB_ROOT_USERNAME" -n '$v'`
q_MONGO_PASSWORD=`jq --arg v "$MONGO_INITDB_ROOT_PASSWORD" -n '$v'`
mongosh -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" admin <<EOF
    use $MONGO_INITDB_DATABASE;
    
    db.createUser({ user: "$MONGO_INITDB_ROOT_USERNAME", pwd:  "$MONGO_INITDB_ROOT_PASSWORD", roles: [{ role:"readWrite",db: "$MONGO_INITDB_DATABASE" } ]});
    
    db.createCollection("clients");
    db.clients.insertOne({ _id: "c1", name: "John", age: 55, email: "john@gmail.com" });
    db.clients.insertOne({ _id: "c2", name: "Bob", age: 23, email: "bob@gmail.com" });
    db.clients.insertOne({ _id: "c3", name: "Alise", age: 34, email: "alise@gmail.com" });
    db.clients.insertOne({ _id: "c4", name: "Marry", age: 45, email: "marry@gmail.com" });
    db.clients.insertOne({ _id: "c5", name: "Tom", age: 18, email: "tom@gmail.com" });


    db.createCollection("workouts");
    db.workouts.insertOne({ _id: "w1", description: "Really difficult", difficulty: 90 });
    db.workouts.insertOne({ _id: "w2", description: "Medium", difficulty: 50 });
    db.workouts.insertOne({ _id: "w3", description: "Really light", difficulty: 30 });

    db.createCollection("trainers");
    db.trainers.insertOne({ _id: "t1", name: "Katty", specialization: "Yoga" });
    db.trainers.insertOne({ _id: "t2", name: "Barbara", specialization: "Crossfit" });
    db.trainers.insertOne({ _id: "t3", name: "Will", specialization: "Box" });



    db.createCollection("memberships");
    db.memberships.insertOne({ _id: "m1", clientId: "c1", workoutId: "w1", trainerId: "t2", startAt: "2021-01-01", endAt: "2021-01-31", type: "basic" });
    db.memberships.insertOne({ _id: "m2", clientId: "c2", workoutId: "w2", trainerId: "t3", startAt: "2021-01-01", endAt: "2021-01-31", type: "pro" });
    db.memberships.insertOne({ _id: "m4", clientId: "c4", workoutId: "w3", trainerId: "t3", startAt: "2021-01-01", endAt: "2021-01-31", type: "pro" });
    db.memberships.insertOne({ _id: "m5", clientId: "c5", workoutId: "w2", trainerId: "t1", startAt: "2021-01-01", endAt: "2021-01-31", type: "basic" });

EOF
