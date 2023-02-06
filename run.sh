#!/bin/bash
cd /opt/guacamole

function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
}

start=${1:-"start"}

jumpto $start

start:
docker compose up -d
docker compose cp style.css guacamole:/style.css
docker compose cp theme.css guacamole:/theme.css
docker compose cp source.css guacamole:/source.css
docker compose cp logo.svg guacamole:/logo.svg
docker compose cp logo-144.png guacamole:/logo-144.png
docker compose cp logo-64.png guacamole:/logo-64.png
docker compose exec -u 0 guacamole /bin/bash -c "mkdir /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /style.css /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /theme.css /home/guacamole/tomcat/webapps/guacamole/custom-css; mv /source.css /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /logo.svg /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;mv /logo-144.png /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;mv /logo-64.png /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/custom-css;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/custom-css;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png"
exit

stop:
docker compose down
exit

restart:
docker compose down
docker compose up -d
docker compose cp style.css guacamole:/style.css
docker compose cp theme.css guacamole:/theme.css
docker compose cp source.css guacamole:/source.css
docker compose cp logo.svg guacamole:/logo.svg
docker compose cp logo-144.png guacamole:/logo-144.png
docker compose cp logo-64.png guacamole:/logo-64.png
docker compose exec -u 0 guacamole /bin/bash -c "mkdir /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /style.css /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /theme.css /home/guacamole/tomcat/webapps/guacamole/custom-css; mv /source.css /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /logo.svg /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;mv /logo-144.png /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;mv /logo-64.png /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/custom-css;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/custom-css;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png"
exit

start-wl:
docker compose up -d
docker compose cp style.css guacamole:/style.css
docker compose cp theme.css guacamole:/theme.css
docker compose cp source.css guacamole:/source.css
docker compose cp logo.svg guacamole:/logo.svg
docker compose cp logo-144.png guacamole:/logo-144.png
docker compose cp logo-64.png guacamole:/logo-64.png
docker compose exec -u 0 guacamole /bin/bash -c "mkdir /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /style.css /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /theme.css /home/guacamole/tomcat/webapps/guacamole/custom-css; mv /source.css /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /logo.svg /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;mv /logo-144.png /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;mv /logo-64.png /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/custom-css;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/custom-css;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png"
docker compose logs -f
exit

restart-wl:
docker compose down
docker compose up -d
docker compose cp style.css guacamole:/style.css
docker compose cp theme.css guacamole:/theme.css
docker compose cp source.css guacamole:/source.css
docker compose cp logo.svg guacamole:/logo.svg
docker compose cp logo-144.png guacamole:/logo-144.png
docker compose cp logo-64.png guacamole:/logo-64.png
docker compose exec -u 0 guacamole /bin/bash -c "mkdir /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /style.css /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /theme.css /home/guacamole/tomcat/webapps/guacamole/custom-css; mv /source.css /home/guacamole/tomcat/webapps/guacamole/custom-css;mv /logo.svg /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;mv /logo-144.png /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;mv /logo-64.png /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/custom-css;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/custom-css;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png"
docker compose logs -f
exit

prepare:
#
# check if docker is running
if ! (docker ps >/dev/null 2>&1)
then
        echo "docker daemon not running, will exit here!"
        exit
fi
echo "Preparing folder init and creating ./init/initdb.sql"
mkdir ./init >/dev/null 2>&1
mkdir -p ./nginx/ssl >/dev/null 2>&1
chmod -R +x ./init
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > ./init/initdb.sql
echo "done"
echo "Creating SSL certificates"
openssl req -nodes -newkey rsa:2048 -new -x509 -keyout nginx/ssl/self-ssl.key -out nginx/ssl/self.cert -subj '/C=DE/ST=BY/L=Hintertupfing/O=Dorfwirt/OU=Theke/CN=www.createyourown.domain/emailAddress=docker@createyourown.domain'
echo "You can use your own certificates by placing the private key in nginx/ssl/self-ssl.key and the cert in nginx/ssl/self.cert"
echo "done"
exit

reset:
echo "This will delete your existing database (./data/)"
echo "          delete your recordings        (./record/)"
echo "          delete your drive files       (./drive/)"
echo "          delete your certs files       (./nginx/ssl/)"
echo ""
read -p "Are you sure? " -n 1 -r
echo ""   # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then # do dangerous stuff
 chmod -R +x -- ./init
 sudo rm -r -f ./data/ ./drive/ ./record/ ./nginx/ssl/
fi
exit

nct-start:
docker compose up -d
docker compose cp logo.svg guacamole:/logo.svg
docker compose cp logo-144.png guacamole:/logo-144.png
docker compose cp logo-64.png guacamole:/logo-64.png
docker compose exec -u 0 guacamole /bin/bash -c "mv /logo.svg /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;mv /logo-144.png /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;mv /logo-64.png /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png"
exit

nct-restart:
docker compose down
docker compose up -d
docker compose cp logo.svg guacamole:/logo.svg
docker compose cp logo-144.png guacamole:/logo-144.png
docker compose cp logo-64.png guacamole:/logo-64.png
docker compose exec -u 0 guacamole /bin/bash -c "mv /logo.svg /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;mv /logo-144.png /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;mv /logo-64.png /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png"
exit

nct-start-wl:
docker compose up -d
docker compose logs -f
docker compose cp logo.svg guacamole:/logo.svg
docker compose cp logo-144.png guacamole:/logo-144.png
docker compose cp logo-64.png guacamole:/logo-64.png
docker compose exec -u 0 guacamole /bin/bash -c "mv /logo.svg /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;mv /logo-144.png /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;mv /logo-64.png /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png"
exit

nct-restart-wl:
docker compose down
docker compose up -d
docker compose logs -f
docker compose cp logo.svg guacamole:/logo.svg
docker compose cp logo-144.png guacamole:/logo-144.png
docker compose cp logo-64.png guacamole:/logo-64.png
docker compose exec -u 0 guacamole /bin/bash -c "mv /logo.svg /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;mv /logo-144.png /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;mv /logo-64.png /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/guac-tricolor.svg;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chmod -c -R 555 /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-144.png;chown guacamole:guacamole /home/guacamole/tomcat/webapps/guacamole/images/logo-64.png"
exit

nl-start:

nl-restart:

nl-start-wl:

nl-restart-wl:

nl-nct-start:

nl-nct-restart:

nl-nct-start-wl:

nl-nct-restart-wl:
