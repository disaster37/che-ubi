
FROM redhat/ubi8-minimal:8.4

ENV \
    GID=1724 \
    UID=1724 \
    GROUP=theia \
    USER=theia \
    HOME=/home/theia \

# Add some standard tools
RUN \
    microdnf install -y sudo git wget curl ca-certificates zip vim make bash tar gzip

# Create user for che and set sudoer profile
RUN \
    groupadd --gid ${GID} ${GROUP} && \
    useradd -c "User for che" -d ${HOME} -m -g ${GROUP} -s /bin/bash -u ${UID} ${USER} &&\
    echo "%${GROUP} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${GROUP}


# Add entrypoint to load custom pki certificates
# Default store is /public-certs
COPY che-entrypoint.sh /che-entrypoint.sh
ENTRYPOINT /che-entrypoint.sh


# Clean
RUN \
    microdnf clean all && \
    rm -rf /tmp/* /var/tmp/*