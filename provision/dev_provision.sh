#!/bin/bash

cd /vagrant/{{ project_name }}/provision
. base_provision.sh

echo "hello from dev env"
pwd

echo $SERVER_NAME
