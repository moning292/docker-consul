# Run Consul Server container

## Project Directory Structure
- cacerts: contains certifactes
- consul-config: all the config files and Consul certificates that need to be copied to a container
- docker: all Docker and Docker Compose related files
- env: all environment variables setup on Docker Host and in a Docker container

## How to spin up
1. Manual run by using Docker CLI
2. source ./env/setEnv.sh
3. Run 
   - sudo -E docker-compose -f docker/docker-compose-consul-server.yml up -d --build
4. Manual run by using Docker Compose
   - Rune docker-compose at the base project directory e.g. sudo docker-compose -f docker/docker-compose-consul-server.yml -p project1 up -d --build
5. Automatic spin up by running Bamboo build plan