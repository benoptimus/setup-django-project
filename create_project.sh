#! /bin/sh

set -euo pipefail




while getopts ":n:s:d:" opt; do
  case $opt in
    n) project_name="$OPTARG"
    ;;
    s) fqdn="$OPTARG"
    ;;
    d) destination="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac

done


echo "Server name                 : $fqdn"
echo "Building django 2.x project : $project_name"
echo "Dest directory              : $destination"

#Check if directory already exists
if [ -d "$destination/$project_name" ]; then
  echo -e "\nProject with the same name already exists into the destination directory\n"
  exit 1
fi

#Check if virtualenv already exists
if [ -d "~/.virtualenvs/$project_name" ]; then
  echo "Project with the same name already exists"
  exit 1
fi

echo -e "Creating virtualenv env_$project_name"
python3 -m venv ~/.virtualenvs/env_$project_name

echo "Launch virtualenv"

source ~/.virtualenvs/env_$project_name/bin/activate

echo "Django installation"
pip install django

echo "Create the project $project_name ..."
django-admin.py startproject --template=https://github.com/fasouto/django-starter-template/archive/master.zip --extension=py,md,html,txt $project_name

echo "Copy Dockerfile inside the project"
cp Dockerfile $project_name/

echo "Copy docker-compose.yml into the project"
cp docker-compose.yml $project_name/

echo "Cleanup project $project_name"
rm -rf $project_name/config
rm -rf $project_name/libs
rm -rf $project_name/tox.ini
rm -rf $project_name/.editorconfig
echo /dev/null > $project_name/readme.md


echo "Copy nginx directory into the project"
cp -r nginx $project_name/

echo "Rewrite nginx default file"
sed -i "s/xxx.yyy.zzz/""$fqdn""/g" $project_name/nginx/default.conf

echo "Rewrite Procfile"
sed -i "s/project_name/""$project_name""/g" $project_name/Procfile

echo "Change PostgreSQL version into Pipfile"
sed -i "s/psycopg2/psycopg2-binary/g" $project_name/Pipfile

echo "Move  $project_name into it's final directory"
mv $project_name $destination/
