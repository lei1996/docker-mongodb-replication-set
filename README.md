
# Docker: MongoDB replication set made simple
This repository should simplify the tedious process of setting up a MongoDB replication set (3 Nodes). Therefore, a shell script is provided, that handles all configuration.

## Usage
Run `setup.sh` with root privileges so that all necessary hostname entries can be made.

**It is mandatory to provide user credentials (username & password) for maximum security.**

Port mapping is not dynamic (yet), so nodes are available via exposed ports:

    Node1: 27011
    Node2: 27012
    Node3: 27013

‼️**Due to the fact that user credentials are stored in plaintext, inside the configuration files, I highly suggest deleting them after the first start.**‼️

**You can then connect to the replication set using following connection string (e.g. locally):**

    mongodb://USERNAME:PASSWORD@mongodb1:27011,mongodb2:27012,mongodb3:27013/admin?replicaSet=REPLICATIONNAME&readPreference=primary&authMechanism=DEFAULT&authSource=admin
