"""
These settings overrides the ones in settings/base.py
"""

DEBUG = True

INTERNAL_IPS = ["127.0.0.1"]

#Change this value at your convenient
SECRET_KEY = "my_secret_key"

# DATABASE SETTINGS
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'postgres',
        'USER': 'postgres',
        'HOST': 'db',
        'PORT': '5432',
    },
}
