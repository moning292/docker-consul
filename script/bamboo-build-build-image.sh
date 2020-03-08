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

echo "Delete the existing files"
rm -rf ${bamboo.REMOTE_DIR}/*
echo "Copy files"
cp -R * ${bamboo.REMOTE_DIR}
echo "+++++++++++++++Starting an image building process+++++++++++++++"
cd ${bamboo.REMOTE_DIR}
source ./env/setEnv.sh
# echo ${bamboo.AD_PASSWORD} | sudo -S docker ps
# echo ${bamboo.AD_PASSWORD} | sudo -S -E docker-compose -f docker/docker-compose-consul-server.yml build
# echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker-compose -f docker/docker-compose-consul-server.yml build
echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -E docker build -f docker/Dockerfile -t ${DOCKER_REPOSITORY_NAME}/consul/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .

echo "+++++++++++++++Image has been built successfully+++++++++++++++"
# echo ${bamboo.AD_PASSWORD} | sudo -S -E docker images| grep moning292-consul
echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker images| grep moning292-consul