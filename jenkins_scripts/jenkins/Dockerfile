FROM jenkins

USER root 

COPY ["entrypoint.sh", "/"]

RUN apt-get update && \
    apt-get install sudo && \
    chmod 755 /entrypoint.sh

ENTRYPOINT ["/bin/bash","-c","./entrypoint.sh"]