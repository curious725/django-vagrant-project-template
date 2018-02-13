#!/bin/bash

cd /vagrant/{{ project_name }}/provision
. base_provision.sh

# add alias for quick work with virtualenv only if it's not already in ~/.bashrc
grep -q -F 'alias cool="source /vagrant/{{ project_name }}/venv/bin/activate;cd /vagrant/{{ project_name }}/src"' ~/.bashrc || \
echo 'alias cool="source /vagrant/{{ project_name }}/venv/bin/activate;cd /vagrant/{{ project_name }}/src"' >> ~/.bashrc && \
source ~/.bashrc
