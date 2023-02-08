# Guacamole with docker-compose
This is a small documentation how to run a fully working **Apache Guacamole (incubating)** instance with docker (docker-compose). The goal of this project is to make it easy to test Guacamole.

## About Guacamole
Apache Guacamole (incubating) is a clientless remote desktop gateway. It supports standard protocols like VNC, RDP, and SSH. It is called clientless because no plugins or client software are required. Thanks to HTML5, once Guacamole is installed on a server, all you need to access your desktops is a web browser.

It supports RDP, SSH, Telnet and VNC and is the fastest HTML5 gateway I know. Checkout the projects [homepage](https://guacamole.incubator.apache.org/) for more information.

# Changes

We made a few Changes to the Dockerfile. Now, it's using a .env file for the Configuration and it's using LDAP Configuration. No clue what LDAP is, basically don't use it. Use the Original Docker File from [boschkundendienst](https://github.com/boschkundendienst/guacamole-docker-compose)


## Prerequisites
You need a working **docker** installation and **docker-compose** running on your machine.

# Quick start
Clone the GIT repository and start guacamole:

~~~bash
git clone "https://github.com/brueggli/guacamole-docker-compose.git"
mkdir /opt/guacamole
cd guacamole-docker-compose
mv ./* /opt/guacamole; mv .env /opt/guacamole
cd /opt/guacamole
sudo bash run.sh prepare
sudo bash run.sh start
~~~

Your guacamole server should now be available at `https://ip of your server:8443/`. The default username is `guacadmin` with password `guacadmin`.

# Configuration

In this whole section, there some things for configure Guacamole.

## .env File

Here is the full .env File for configurations

Shortcuts: 

~~~python
PG_DB="guacamole_db" # POSTGRES_DATABASE
PG_HOSTNAME="postgres" # POSTGRES_HOSTNAME
PG_PASS="ChooseYourOwnPasswordHere1234" # POSTGRES_PASSWORD
PG_USER="guacamole_user" # POSTGRES_USER
PG_IMAGE="postgres:13.4-buster" # POSTGRES_IMAGE
PG_CN="postgres_guacamole_compose" # POSTGRES_CONTAINER_NAME
LDAP_HOSTNAME="192.168.1.2" # LDAP_HOSTNAME
LDAP_USER_BASE="OU=Folder,OU=COMPANY.DOMAIN,DC=COMPANY,DC=local" # LDAP_USER_BASE_DN
LDAP_SEARCH="CN=userforguacamole,OU=Folder,OU=COMPANY.DOMAIN,DC=COMPANY,DC=local" # LDAP_SEARCH_BIND_DN
LDAP_SEARCH_PASS="ChooseYourOwnPasswordHere1234" # LDAP_SEARCH_BIND_PASSWORD
LDAP_USER_ATTRIBUTE="sAMAccountName" # LDAP_USERNAME_ATTRIBUTE
LDAP_GROUP_BASE="OU=Group,OU=COMPANY.DOMAIN,DC=COMPANY,DC=local" #LDAP_GROUP_BASE_DN
NGINX_SSL_CERT="./nginx/ssl/self.cert:/etc/nginx/ssl/self.cert:ro" # Directory to the SSL Cert
NGINX_SSL_KEY="./nginx/ssl/self-ssl.key:/etc/nginx/ssl/self-ssl.key:ro" # Directory to the SSL Key
NGINX_CONF="./nginx/nginx.conf:/etc/nginx/nginx.conf:ro" # Directory to the NGINX Config
NGINX_SITE_CONF="./nginx/mysite.template:/etc/nginx/conf.d/default.conf:ro" # Directory to the NGINX Site Config
NGINX_CN="nginx_guacamole_compose" # NGINX_CONTAINER_NAME
GUAC_HOSTNAME="guacd" # GUACAMOLE_HOSTNAME
GUAC_CN="guacamole_compose" # GUACAMOLE_CONTAINER_NAME
GUACD_CN="guacd_compose" # GUACD_CONTAINER_NAME
~~~

## LDAP Configuration

If you want to use LDAP, here u go

~~~~python
LDAP_HOSTNAME="192.168.1.2" # LDAP_HOSTNAME
LDAP_USER_BASE="OU=Folder,OU=COMPANY.DOMAIN,DC=COMPANY,DC=local" # LDAP_USER_BASE_DN
LDAP_SEARCH="CN=userforguacamole,OU=Folder,OU=COMPANY.DOMAIN,DC=COMPANY,DC=local" # LDAP_SEARCH_BIND_DN
LDAP_SEARCH_PASS="ChooseYourOwnPasswordHere1234" # LDAP_SEARCH_BIND_PASSWORD
LDAP_USER_ATTRIBUTE="sAMAccountName" # LDAP_USERNAME_ATTRIBUTE
LDAP_GROUP_BASE="OU=Group,OU=COMPANY.DOMAIN,DC=COMPANY,DC=local" #LDAP_GROUP_BASE_DN
~~~~

[LDAP Documentation for Docker](https://guacamole.apache.org/doc/1.4.0/gug/guacamole-docker.html#ldap-authentication)

## LDAP Configuration on a Windows Server with Active Directory

1. The User for Guacamole only needs two Permissions: 
- ReadUnixUserPassword

and

- ReadUserParameters

2. Enable LDAP, see here: [Enable LDAP using Group Policy](https://learn.microsoft.com/en-us/troubleshoot/windows-server/identity/enable-ldap-signing-in-windows-server#how-to-set-the-server-ldap-signing-requirement)

3. If you run into issue like "The server requires binds to turn on integrity checking if SSL\TLS are not already active on the connection" check the following Article: [Fix integrity checking for SSL\TLS](https://informatics-support.perkinelmer.com/hc/en-us/articles/4408237608596-LdapErr-DSID-0C090257-comment-The-server-requires-binds-to-turn-on-integrity-checking-if-SSL-TLS-are-not-already-active-on-the-connection)

4. For user-permissions simply create a group on the Active Directory, add the users who need access to the group, go to the Guacamole adminpanel, create a group with the same name as the active directory group and give the permissions they need.

Guacamole only checks, if the groups, where the user are in, also existing the the local database, if yes, it simply give the permission who are set for the group to the user.

## Custom Theme

Official not supported but with the Power of NGINX, it's possible to create Themes for Guackamole.
The following code is new in the `mysite.template` config.
~~~python
    proxy_set_header Accept-Encoding "";
    sub_filter
    '</head>'
    '<link rel="stylesheet" type="text/css" href="/custom-css/brueggli.css">
    </head>';
    sub_filter_once on;
~~~
For the files, the run.sh script copy the required files into the docker container and set the right permissions.

This set the Accept-Encoding Header to "" an create a sub_filter. In this sub_filter it replace the end of the header (`</head>`) with `'<link rel="stylesheet" type="text/css" href="/custom-css/style.css"></head>'`

Default, it use the [space-gray](https://docs.theme-park.dev/site_assets/guacamole/space-gray.png) Theme from [here](https://docs.theme-park.dev/themes/guacamole/#screenshots)

But you can download the `theme.css` and edit it, then overwrite it and restart all containers with `sudo bash run.sh restart`

Otherwise, if you don't want a custom theme, you can simply add `nct-` before `start`, `restart`, `restart-wl` or `start-wl` like `sudo bash run.sh nct-restart`

If you already import a custom theme and you don't want it anymore, simply type `sudo bash run.sh nct-restart` and your custom theme are gone, it still presents on the host-machine.

## Custom Logos

Official also not supported, but it's now possible to use your own Logos in Guacamole.

For setting up your own logo your need three files to replace in `/opt/guacamole`:

- `logo.svg` with your logo as a `.svg` file, size doesn't matter
- `logo-64.png` with your logo as a `.png` file --> size: 64x64
- `logo-144.png` with your logo as a `.png` file --> size: 144x144

After uploading your logos to `/opt/guacamole` run `sudo bash run.sh restart` to add your logos to guacamole.

If you don't want a custom logo, set `nl-` before `start`, `restart`, `start-wl` or `restart-wl` like `sudo bash run.sh nl-restart`

# Details
To understand some details let's take a closer look at parts of the `docker-compose.yml` file:

### Networking
The following part of docker-compose.yml will create a network with name `guacnetwork_compose` in mode `bridged`.
~~~python
...
# networks
# create a network 'guacnetwork_compose' in mode 'bridged'
networks:
  guacnetwork_compose:
    driver: bridge
...
~~~

### Services
#### guacd
The following part of docker-compose.yml will create the guacd service. guacd is the heart of Guacamole which dynamically loads support for remote desktop protocols (called "client plugins") and connects them to remote desktops based on instructions received from the web application. The container will be called `guacd_compose` based on the docker image `guacamole/guacd` connected to our previously created network `guacnetwork_compose`. Additionally we map the 2 local folders `./drive` and `./record` into the container. We can use them later to map user drives and store recordings of sessions.

~~~python
...
services:
  # guacd
  guacd:
    container_name: '${GUACD_CN}'
    image: guacamole/guacd
    networks:
      guacnetwork_compose:
    restart: always
    volumes:
    - ./drive:/drive:rw
    - ./record:/record:rw
...
~~~

#### PostgreSQL
The following part of docker-compose.yml will create an instance of PostgreSQL using the official docker image. This image is highly configurable using environment variables. It will for example initialize a database if an initialization script is found in the folder `/docker-entrypoint-initdb.d` within the image. Since we map the local folder `./init` inside the container as `docker-entrypoint-initdb.d` we can initialize the database for guacamole using our own script (`./init/initdb.sql`). You can read more about the details of the official postgres image [here](https://www.postgresql.org/docs/13/index.html).

~~~python
...
  postgres:
    container_name: '${PG_CN}'
    environment:
      PGDATA: /var/lib/postgresql/data/guacamole
      POSTGRES_DB: '${PG_DB}'
      POSTGRES_PASSWORD: '${PG_PASS}'
      POSTGRES_USER: '${PG_USER}'
    image: '${PG_IMAGE}'
    networks:
      guacnetwork_compose:
    restart: always
    volumes:
    - ./init:/docker-entrypoint-initdb.d:z
    - ./data:/var/lib/postgresql/data:Z
...
~~~

#### Guacamole
The following part of docker-compose.yml will create an instance of guacamole by using the docker image `guacamole` from docker hub. It is also highly configurable using environment variables. In this setup it is configured to connect to the previously created postgres instance using a username and password and the database `guacamole_db`. Port 8080 is only exposed locally! We will attach an instance of nginx for public facing of it in the next step.

~~~python
...
  guacamole:
    container_name: '${GUAC_CN}'
    depends_on:
    - guacd
    - postgres
    environment:
      GUACD_HOSTNAME: '${GUAC_HOSTNAME}'
      POSTGRES_DATABASE: '${PG_DB}'
      POSTGRES_HOSTNAME: '${PG_HOSTNAME}'
      POSTGRES_PASSWORD: '${PG_PASS}'
      POSTGRES_USER: '${PG_USER}'
      LDAP_HOSTNAME: '${LDAP_HOSTNAME}'
      LDAP_USER_BASE_DN: '${LDAP_USER_BASE}'
      LDAP_SEARCH_BIND_DN: '${LDAP_SEARCH}'
      LDAP_SEARCH_BIND_PASSWORD: '${LDAP_SEARCH_PASS}'
      LDAP_USERNAME_ATTRIBUTE: '${LDAP_USER_ATTRIBUTE}'
      LDAP_GROUP_BASE_DN: '${LDAP_GROUP_BASE}'
    image: guacamole/guacamole
    links:
    - guacd
    networks:
      guacnetwork_compose:
    ports:
## Ports with .env File are not possible to configure with Guacamole and NGINX
## enable next line if not using nginx
##    - 8080:8080/tcp # Guacamole is on :8080/guacamole, not /.
## enable next line when using nginx
    - 8080/tcp
    restart: always
...
~~~

#### nginx
The following part of docker-compose.yml will create an instance of nginx that maps the public port 8443 to the internal port 443. The internal port 443 is then mapped to guacamole using the `./nginx.conf` and `./nginx/mysite.template` files. The container will use the previously generated (`prepare.sh`) self-signed certificate in `./nginx/ssl/` with `./nginx/ssl/self-ssl.key` and `./nginx/ssl/self.cert`.

~~~python
...
  nginx:
   container_name: '${NGINX_CN}'
   restart: always
   image: nginx
   volumes:
   - '${NGINX_SSL_CERT}'
   - '${NGINX_SSL_KEY}'
   - '${NGINX_CONF}'
   - '${NGINX_SITE_CONF}'
   ports:
   - 8443:8443
   links:
   - guacamole
   networks:
     guacnetwork_compose:
   # run nginx
   command: /bin/bash -c "nginx -g 'daemon off;'"
...
~~~

# run.sh

`run.sh` includes all the useful commands for prepare, reset, run, restart and stop the containers. This means that `prepare.sh` and `reset.sh` are not longer needed.

Below is a list with all commands, that `run.sh` supports

Attention: Run `run.sh` with root privileges

`sudo bash run.sh` starts all Docker-Container and copy the files for the custom-theme and copy your custom logo into the docker-container

`sudo bash run.sh start` does the same thing

`sudo bash run.sh start-wl` does the same thing as start but at the end it goes directly into the live-logs

`sudo bash run.sh restart` does shutdown all containers and after that it repeats the same as `start` does

`sudo bash run.sh restart-wl` does the same as restart but at the end, it will go directly into the live-logs so you can check if something goes terribly wrong

`sudo bash run.sh stop` simply stop all Containers

`sudo bash run.sh prepare` runs `prepare.sh` builtin `run.sh`

`sudo bash run.sh reset` runs `reset.sh` builtin `run.sh`

`sudo bash run.sh nct-start` does the same thing as `start` but with no custom theme and with the logos

`sudo bash run.sh nct-start-wl` does the same thing as `nct-start` but it goes into the live-logs after the start

`sudo bash run.sh nct-restart` does the same thing as `restart` but with no custom theme and with logos

`sudo bash run.sh nct-restart-wl` does the same thing as `nct-restart` but after the restart, the live-logs will show up

`sudo bash run.sh nl-start` does the same thing as `start` but only with the custom-theme, no logos

`sudo bash run.sh nl-restart` does the sane thing as `restart` but only with custom-theme and no logos

`sudo bash run.sh nl-start-wl` does the same thing as `nl-start` but at the end, it goes into the logs

`sudo bash run.sh nl-restart-wl` does the same thing as `nl-restart` but it goes into the logs after a successfully restart

`sudo bash run.sh nl-nct-start` does the same thing as `start` but with no custom-theme and no custom logos

`sudo bash run.sh nl-nct-restart` does the same thing as `restart` but with no custom-theme and no custom logos

`sudo bash run.sh nl-nct-start-wl` does the same thing as `nl-nct-start` but goes into the logs after start

`sudo bash run.sh nl-nct-restart-wl` does the same thing as `nl-nct-restart` but goes into the logs after a restart

## prepare.sh

`prepare.sh` is now builtin `run.sh` and will now run with `sudo bash run.sh prepare`, the file `prepare.sh` got deleted but here are the original docs what `prepare.sh` actually does:

`prepare.sh` is a small script that creates `./init/initdb.sql` by downloading the docker image `guacamole/guacamole` and start it like this:

~~~bash
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > ./init/initdb.sql
~~~

It creates the necessary database initialization file for postgres.

`prepare.sh` also creates the self-signed certificate `./nginx/ssl/self.cert` and the private key `./nginx/ssl/self-ssl.key` which are used
by nginx for https.

## reset.sh

`reset.sh` is now builtin `run.sh` and will now run with `sudo bash run.sh reset`, the file `reset.sh` got deleted but here are the original docs what `reset.sh` actually does:

To reset everything to the beginning, just run `sudo bash run.sh reset`.

# WOL

Wake on LAN (WOL) does not work and We will not fix that because it is beyond the scope of this repo. But there a two Solutions for this:

1. Change the Docker Network Driver to host
2. (Only works on Debian or Ubuntu) Install a Script who make a few changes to Docker and then it will work. [Wake-on-LAN from Guacamole in docker](https://frigi.ch/en/2022/07/wake-on-lan-from-guacamole-in-docker/)

**Disclaimer**

Downloading and executing scripts from the internet may harm your computer. Make sure to check the source of the scripts before executing them!
