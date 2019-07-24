# Django 2.x project creator #

To create a project django easily. Too many commands to type in each new project to start. The stack I use (very basic):
- Django
- PostgreSQL
- Nginx

Each component is placed in a docker container


## Prerequisites ##

- docker (Install Docker according to your system Mac or Linux)

You can use the script at https://get.docker.com/ to download and install docker

```
curl https://get.docker.com/ >> install_docker.sh
sudo chmod +x install_docker.sh
./install_docker.sh
sudo systemctl start docker
```

- Install docker-compose
```
sudo pip install docker-compose
```

## Project setup ##

### How to do it ? ###

- Make sure you are at the root of the project
```
- cd setup
- ./create_project.sh -n myproject -s myfqdn -d destination_directory

```
- myproject : is the name given to your project
- myfqdn : Full qualified domain name. The server name to be used into your basic nginx default config file
- destination_directory : The directory in which the project will be moved after the creation.
  You can just put "." to specify the current directory


## Complete project Setup ##

### Method 1 ###

- First Build of the project with docker
```
- docker build .
```

- Create necessary tables and migrate database
```
- docker-compose run web python /code/manage.py migrate --noinput
```

- Run test to assure everything is OK
```
- docker-compose run web python /code/manage.py test
```

- Collect static files in order to serve statics with nginx
```
- docker-compose run web python /code/manage.py collectstatic --noinput
```

- Create a superuser in order to access Django admin IHM
```
- docker-compose run web python /code/manage.py superuser --username test1 --password 123321 --noinput --email 'admin@email.com'
```

- Build again project and up with docker-compose in detached mode. You can remove ```-d``` option
```
- docker-compose up -d --build
```

I know the first method is too long. So why not see the second method. You just have to launch another script

pre copied in the project.

### Method 2 ###
Make sure to be on the root of your project

```
- chmod +x deploy.sh
- ./deploy.sh
```
