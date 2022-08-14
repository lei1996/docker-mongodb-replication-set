#!/bin/bash

echo "Adding hosts entries..."
echo '127.0.0.1       mongodb1' >> /etc/hosts
echo '127.0.0.1       mongodb2' >> /etc/hosts
echo '127.0.0.1       mongodb3' >> /etc/hosts

echo "MongoDB information:"
read -p "Username: " username
read -sp "Password: " password
echo
read -p "Replication set name: " repname
echo
echo "Username: $username  Password: $password"
echo

#Set credentials in createAdmin script
sed -i '' -e "s/{USERNAME}/$username/" ./set_primary/createAdmin.js
sed -i '' -e "s/{PASSWORD}/$password/" ./set_primary/createAdmin.js

#Set credentials in entry script
sed -i '' -e "s/{USERNAME}/$username/" ./set_primary/entry.sh
sed -i '' -e "s/{PASSWORD}/$password/" ./set_primary/entry.sh

#Set replication set name
sed -i '' -e "s/{REPLICATIONNAME}/$repname/" ./set_primary/createReplicationSet.js
sed -i '' -e "s/{REPLICATIONNAME}/$repname/" ./set_primary/entry.sh
sed -i '' -e "s/{REPLICATIONNAME}/$repname/" ./docker-compose.yaml


#Create keyfile
echo "Generating new key file..."
openssl rand -base64 756 > keyfile.key
cp keyfile.key ./set/
mv keyfile.key ./set_primary/keyfile.key

read -p "Do you want to start MongoDB? The first start may take some time. (y/n): " start

if [[ $start == *"y"* ]];
then
    #Start container stack
    docker-compose up --detach
else
    echo "You can start MongoDB at a later point in time using: 'docker-compose up --detach' inside this folder. The first start may take some time..."
fi

echo
echo

read -p "Consider deleting everything apart from the volumes folder due to plaintext credentials inside configuration files..."
