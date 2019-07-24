#!/bin/bash
# Challenge deploy script
pip install docker-compose

#Project setup ##
docker build .

#Create necessary tables and migrate database
docker-compose run web python /code/manage.py migrate --noinput


#Run test to assure everything is OK
docker-compose run web python /code/manage.py test


#Collect static files in order to serve statics with nginx
docker-compose run web python /code/manage.py collectstatic --noinput

#Create a superuser in order to access Django admin IHM
docker-compose run web python /code/manage.py superuser --username admin --password admin_password --noinput --email 'admin@email.com'


#Build again project and up with docker-compose in detached mode. You can remove ```-d``` option
docker-compose up -d --build
