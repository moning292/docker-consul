#!/bin/bash

export BAMBOO_DOCKER_REPOSITORY_NAME=${bamboo.DOCKER_REPOSITORY_NAME}
# export BAMBOO_DOCKER_IMAGE_NAME=${bamboo.DOCKER_IMAGE_NAME}
# export BAMBOO_DOCKER_IMAGE_TAG=${bamboo.DOCKER_IMAGE_TAG}
export BAMBOO_CONSUL_BOOTSTRAP_NO=${bamboo.CONSUL_BOOTSTRAP_NO}
export BAMBOO_COMPOSE_PROJECT_NAME=${bamboo.COMPOSE_PROJECT_NAME}
export BAMBOO_CONSUL_PRIMARY_ADDR=${bamboo.CONSUL_PRIMARY_ADDR}
export BAMBOO_CONSUL_ADVERTISE_ADDR=${bamboo.CONSUL_ADVERTISE_ADDR}
export BAMBOO_CONSUL_DATA_VOLUME=${bamboo.CONSUL_DATA_VOLUME}
export BAMBOO_EXPOSE_PORT_1=${bamboo.EXPOSE_PORT_1}
export BAMBOO_EXPOSE_PORT_2=${bamboo.EXPOSE_PORT_2}
export BAMBOO_EXPOSE_PORT_3=${bamboo.EXPOSE_PORT_3}
export BAMBOO_EXPOSE_PORT_4=${bamboo.EXPOSE_PORT_4}
export BAMBOO_EXPOSE_PORT_5=${bamboo.EXPOSE_PORT_5}
export BAMBOO_EXPOSE_PORT_6=${bamboo.EXPOSE_PORT_6}

cd ${bamboo.REMOTE_DIR}
source ./env/setEnv.sh

export COMPOSE_COMMAND="agent -server -node ${bamboo.HOSTNAME} -bootstrap-expect ${CONSUL_BOOTSTRAP_NO} -ui -client 0.0.0.0 -advertise ${CONSUL_ADVERTISE_ADDR}"

echo "Consul command is $COMPOSE_COMMAND"

echo "Project name is $COMPOSE_PROJECT_NAME"

echo "Copy Service Config to /consul/data/service-config/"
echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker exec ${COMPOSE_PROJECT_NAME}_consul-server_1 /bin/sh -c 'find /consul/config/ -type f -and ! -name "acl*" -and ! -name "common*" -exec cp -rf {} /consul/data/service-config/ \;'

#echo "Docker Compose Down"
#echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker-compose -f docker/docker-compose-consul-server.yml down --rmi all

# echo ${bamboo.AD_PASSWORD} | sudo -S -E docker-compose -f docker/docker-compose-consul-server.yml up -d
echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker-compose -f docker/docker-compose-consul-server.yml up -d --force-recreate

sleep 10



# if [[ -z $(echo ${bamboo.AD_PASSWORD} | sudo -S -E docker-compose -f docker/docker-compose-consul-server.yml ps -q) ]]
if [[ -z $(echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker-compose -f docker/docker-compose-consul-server.yml ps -q) ]]
then
    echo "Container is NOT running!!!"
    exit 1
else
    echo "The service is running"
fi

sleep 10

# if [[ -z $(echo ${bamboo.AD_PASSWORD} | sudo -S -E docker-compose -f docker/docker-compose-consul-server.yml ps -q) ]]
if [[ -z $(echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker-compose -f docker/docker-compose-consul-server.yml ps -q) ]]
then
    echo "Container is NOT running!!!"
    exit 1
else
    echo "The service is running"
fi

echo "Copy Service Config to /consul/config/"
echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker exec ${COMPOSE_PROJECT_NAME}_consul-server_1 /bin/sh -c 'find /consul/data/service-config/ -type f -and ! -name "acl*" -and ! -name "common*" -exec cp -rf {} /consul/config/ \;'
echo "Consul >>> Reload Service Config"
echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker exec ${COMPOSE_PROJECT_NAME}_consul-server_1 /bin/sh -c 'consul reload'
echo "Add Cron Job to backup service config"
echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker exec ${COMPOSE_PROJECT_NAME}_consul-server_1 /bin/sh -c 'echo "0       0       */8       *       *       find /consul/config/ -type f -and ! -name acl* -and ! -name common* -exec cp -rf {} /consul/data/service-config/ \;" >> /var/spool/cron/crontabs/root'

#echo ${bamboo.AD_PASSWORD} | sudo -S -E docker-compose -f docker/docker-compose-consul-server.yml down