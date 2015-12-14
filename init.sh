#!/bin/bash

# Generate md5 pool_passwd
cd /usr/local/etc/

while read user pass
do
  echo "Generate pg_md5 password for user: $user"
  pg_md5 -m -u $user $pass
done < /usr/local/etc/pool_passwd_plain

sudo pgpool -D -n
