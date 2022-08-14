FROM mongo
WORKDIR /root/
COPY keyfile.key .
COPY createAdmin.js .
COPY createReplicationSet.js .
COPY entry.sh .
RUN chmod 400 /root/keyfile.key
