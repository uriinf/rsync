#!/bin/bash
ALLOW=${ALLOW:-192.168.0.0/16 172.16.0.0/12 10.0.0.0/8}
RSYNC_UID=${RSYNC_UID:-root}
RSYNC_GID=${RSYNC_GID:-root}
echo "$USERNAME:$PASSWORD" > /etc/rsyncd.secrets
chmod 0400 /etc/rsyncd.secrets

[ -f /etc/rsyncd.conf ] || cat <<EOF > /etc/rsyncd.conf
pid file = /var/run/rsyncd.pid
log file = /dev/stdout
timeout = 300
max connections = 10
[data]
    uid = ${RSYNC_UID}
    gid = ${RSYNC_GID}
    hosts deny = *
    hosts allow = ${ALLOW}
    read only = false
    path = /rsync_dir
    comment = data directory
    auth users = $USERNAME
    secrets file = /etc/rsyncd.secrets
EOF

exec /usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf "$@"
