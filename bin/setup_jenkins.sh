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

# #setup the build container
# oc new-build --strategy=docker -D $'FROM quay.io/openshift/origin-jenkins-agent-base:4.7.0\n
#    USER root\n
#    RUN rm -f /etc/yum.repos.d/* && \ \n
#    curl https://raw.githubusercontent.com/ramius345/golang_jenkins_demo/master/slave_container/centos.repo -o /etc/yum.repos.d/centos.repo && \ \n
#    yum -y --setopt=tsflags=nodocs install skopeo golang && yum clean all\n
#    USER 1001' --name=jenkins-agent-appdev -n $JENKINS_NAMESPACE


echo "apiVersion: v1
items:
- kind: \"BuildConfig\"
  apiVersion: \"v1\"
  metadata:
    name: \"go-app-1-pipeline\"
  spec:
    source:
      type: \"Git\"
      git:
        uri: \"https://github.com/ramius345/golang_jenkins_demo.git\"
      contextDir: go_app_1
    strategy:
      type: \"JenkinsPipeline\"
      jenkinsPipelineStrategy:
        jenkinsfilePath: Jenkinsfile
kind: List
metadata: []" | oc create -f - -n $JENKINS_NAMESPACE
