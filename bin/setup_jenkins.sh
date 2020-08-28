#!/bin/bash

source namespaces.env

# #create the openshift project/kubernetes namespace
# oc new-project $JENKINS_NAMESPACE

# #instantiate the jenkins perstistent template
# #oc new-app jenkins-persistent  --param MEMORY_LIMIT=2Gi --param VOLUME_CAPACITY=4Gi --param DISABLE_ADMINISTRATIVE_MONITORS=true
# oc new-app jenkins-ephemeral  --param MEMORY_LIMIT=4Gi --param DISABLE_ADMINISTRATIVE_MONITORS=true

# #set the DC resources
# oc set resources dc jenkins --limits=memory=2Gi,cpu=2 --requests=memory=1Gi,cpu=500m -n ${JENKINS_NAMESPACE}

# sleep 5

# #expose the jenkins service
# oc expose svc jenkins -n $JENKINS_NAMESPACE

#setup the build container
oc new-build --strategy=docker -D $'FROM quay.io/openshift/origin-jenkins-agent-base:4.7.0\n
   USER root\n
   RUN curl https://copr.fedorainfracloud.org/coprs/alsadi/dumb-init/repo/epel-7/alsadi-dumb-init-epel-7.repo -o /etc/yum.repos.d/alsadi-dumb-init-epel-7.repo && \ \n
   curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \ \n
   curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \ \n
   DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" && \ \n
   yum $DISABLES -y --setopt=tsflags=nodocs install skopeo golang && yum clean all\n
   USER 1001' --name=jenkins-agent-appdev -n $JENKINS_NAMESPACE


