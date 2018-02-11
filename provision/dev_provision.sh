#!/bin/bash

cd /vagrant/{{ project_name }}/provision
. base_provision.sh

echo "hello from dev env"
echo $SERVER_NAME
