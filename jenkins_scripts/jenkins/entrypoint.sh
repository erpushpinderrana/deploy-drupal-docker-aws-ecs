#!/bin/bash

if [ -S ${DOCKER_SOCKET} ]; then
    DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})
    groupadd -for -g ${DOCKER_GID} ${DOCKER_GROUP}
    usermod -aG ${DOCKER_GROUP} ${JENKINS_USER}
fi

exec sudo -E -H -u jenkins bash -c /usr/local/bin/jenkins.sh