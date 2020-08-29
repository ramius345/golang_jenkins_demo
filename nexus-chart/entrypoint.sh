#!/bin/bash
# From the original container
# "Env": [
#     "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
#     "container=oci",
#     "SONATYPE_DIR=/opt/sonatype",
#     "NEXUS_HOME=/opt/sonatype/nexus",
#     "NEXUS_DATA=/nexus-data",
#     "NEXUS_CONTEXT=",
#     "SONATYPE_WORK=/opt/sonatype/sonatype-work",
#     "DOCKER_TYPE=rh-docker",
#     "INSTALL4J_ADD_VM_PARAMS=-Xms2703m -Xmx2703m -XX:MaxDirectMemorySize=2703m -Djava.util.prefs.userRoot=/nexus-data/javaprefs"
# ],
# "Cmd": [
#     "sh",
#     "-c",
#     "${SONATYPE_DIR}/start-nexus-repository-manager.sh"
# ],

#if the initialization tar is here, then unpack it
if [ -f /orig-nexus-data.tar.gz ]; then
    touch /nexus-data/initialized.txt
    rm -rf /nexus-data/*
    tar -xzvf /orig-nexus-data.tar.gz
    rm /orig-nexus-data.tar.gz
fi

/bin/sh -c "${SONATYPE_DIR}/start-nexus-repository-manager.sh"
