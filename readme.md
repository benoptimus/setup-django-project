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

###Please follow this instructions to setup the project locally in a docker container

- Make sure you are at the root of the project
```
- cd setup
- ./create_project.sh -n myproject -s myfqdn -d destination_directory

```
- myproject : is the name given to your project
- myfqdn : Full qualified domain name. The server name to be used into your basic nginx default config file
- destination_directory : The directory in which the project will be moved after the creation.
  You can juste put "." to specify the current directory
