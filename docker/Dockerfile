FROM consul:latest

# COPY ./cacerts/prod /usr/local/share/ca-certificates
# COPY ./cacerts/test /usr/local/share/ca-certificates

# RUN /bin/sh -c 'update-ca-certificates'

COPY ./consul-config /consul/config

# ENTRYPOINT ["docker-entrypoint.sh"]