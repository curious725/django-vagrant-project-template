#!/bin/bash

cd /vagrant/{{ project_name }}/provision
. base_provision.sh

echo "hello from prod env"
echo $SERVER_NAME
