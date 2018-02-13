#!/bin/bash

cd /vagrant/{{ project_name }}/provision
. base_provision.sh


cd /vagrant/{{ project_name }}/src
python manage.py collectstatic --settings=$DJANGO_SETTINGS_MODULE


dpkg -s nginx &>/dev/null || {
  sudo apt-get install -y nginx
}

dpkg -s supervisor &>/dev/null || {
  sudo apt-get install -y supervisor
}

sudo systemctl enable supervisor
sudo systemctl start supervisor

cd /vagrant/{{ project_name }}/config

chmod u+x gunicorn_start

cd /vagrant/{{ project_name }}/
mkdir run logs

sudo cp /vagrant/{{ project_name }}/config/{{ project_name }}.supervisor.conf /etc/supervisor/conf.d/{{ project_name }}.supervisor.conf


sudo supervisorctl reread
sudo supervisorctl update

sudo service supervisor restart

sudo rm /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-available/default

sudo cp /vagrant/{{ project_name }}/config/{{ project_name }}.nginx.conf /etc/nginx/sites-available/{{ project_name }}.nginx.conf

sudo sed -i "s/server_name ;/server_name $SERVER_NAME;/" /etc/nginx/sites-available/{{ project_name }}.nginx.conf

sudo ln -s /etc/nginx/sites-available/{{ project_name }}.nginx.conf /etc/nginx/sites-enabled/{{ project_name }}.nginx.conf
sudo service nginx restart

