FROM node:6.10.2
# replace this with your application's default port


ENV HOME=/srv/package

WORKDIR ${HOME}

# For ohcm-mq dependencies - Needs to be removed when they are added to base images
USER root

# Copy package.json for npm install
COPY ./package.json ${HOME}/package.json

# Run npm install
RUN cd /${HOME} && npm install --loglevel info && npm cache clean


# Copy the stuff which we imagine may have changed - if we are doing a build
COPY ./ ${HOME}/

# --- Dockerfile specific ---

ENV SERVICE_8080_NAME=phishing \
    SERVICE_8080_TAGS=discoverable \
    PORT=8080

EXPOSE 8080

EXPOSE 80

USER root

CMD /usr/local/bin/node bin/www
