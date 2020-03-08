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

echo "Start pushing a Docker image"

cd ${bamboo.REMOTE_DIR}
source ./env/setEnv.sh

# echo ${bamboo.AD_PASSWORD} | sudo -S docker login -u ${bamboo.AD_USER} -p ${bamboo.AD_PASSWORD} ${bamboo.DOCKER_REPOSITORY_NAME}
echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker login -u ${bamboo.AD_USER} -p ${bamboo.AD_PASSWORD} $DOCKER_REPOSITORY_NAME

# echo ${bamboo.AD_PASSWORD} | sudo -S docker tag moning292-consul:0.1 ${bamboo.DOCKER_REPOSITORY_NAME}/consul/moning292-consul:0.1
# echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker tag $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG $DOCKER_REPOSITORY_NAME/consul/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG

# echo ${bamboo.AD_PASSWORD} | sudo -S docker push ${bamboo.DOCKER_REPOSITORY_NAME}/consul/moning292-consul:0.1
echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker push $DOCKER_REPOSITORY_NAME/consul/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG

echo "Tear down a Docker container"
# echo ${bamboo.AD_PASSWORD} | sudo -S -E docker-compose -f docker/docker-compose-consul-server.yml down
echo ${bamboo.AD_PASSWORD} | sudo -u moning292 -S -E docker-compose -f docker/docker-compose-consul-server.yml down