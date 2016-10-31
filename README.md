rsync
=====

This is fork from https://github.com/bfosberry/rsync.
Link to docker hub https://hub.docker.com

Do not use it as permanent service. It has been created for periodic synchronization and for CI/CD purposes.

## Usage

#### Run docker once and synchronize data to /var/www/html:
```sh
docker run --rm -p 873:873 -v /var/www/html:/rsync_dir:rw -e RSYNC_DIR="/rsync_dir" -e USERNAME="rsyncuser" -e PASSWORD="rsyncpassword" --name rsync uriinf/rsync
```
Synchronize data:
```sh
RSYNC_PASSWORD=rsyncpassword rsync -a mydomain.com_dir  rsync://rsyncuser@YOUR_HOST:873/data/
```

## Environment Variables:
* ALLOW - IP addresses to allow connection in CIDR format, support multiple values splitted with space. By default all private networks allowed: ALLOW="192.168.0.0/16 172.16.0.0/12 10.0.0.0/8"
* RSYNC_UID - system uid specifies the user name or user ID that file transfers, should be able to read/write to destination directory. default is root. It may be www-data for /var/www/html for example.
* RSYNC_GID - system gid, look RSYNC_UID, default is root. It may be www-data for /var/www/html for example.
