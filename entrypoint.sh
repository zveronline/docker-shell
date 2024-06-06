#!/bin/bash
set -e
#cp -r /config/ssh/* /root/.ssh/
cp -r /config/host/* /etc/ssh/
if [ ! -f /etc/ssh/ssh_host_rsa_key ]
then
  ssh-keygen -A
fi
exec "$@"
