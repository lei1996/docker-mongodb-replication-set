if test -f "/root/first_start"; then
    /usr/bin/mongod --port 27011 --bind_ip_all --replSet {REPLICATIONNAME} --keyFile /root/keyfile.key

else
    /usr/bin/touch /root/first_start
    /usr/bin/mongod --fork --logpath /root/mongo.log --port 27011 --bind_ip_all
    /usr/bin/mongosh "mongodb://localhost:27011/" < /root/createAdmin.js
    /usr/bin/pkill mongod
    echo "Waiting...."
    sleep 10
    /usr/bin/mongod --fork --logpath /root/mongo.log --port 27011 --replSet {REPLICATIONNAME} --bind_ip_all --keyFile /root/keyfile.key
    /usr/bin/mongosh "mongodb://{USERNAME}:{PASSWORD}@localhost:27011/" < /root/createReplicationSet.js
    sleep 5
    reboot
fi

exec "$@"