#!/bin/bash

source namespaces.env

#create the openshift project/kubernetes namespace
oc new-project $JENKINS_NAMESPACE

#instantiate the jenkins perstistent template
#oc new-app jenkins-persistent  --param MEMORY_LIMIT=2Gi --param VOLUME_CAPACITY=4Gi --param DISABLE_ADMINISTRATIVE_MONITORS=true
oc new-app jenkins-ephemeral  --param MEMORY_LIMIT=4Gi --param DISABLE_ADMINISTRATIVE_MONITORS=true

#set the DC resources
oc set resources dc jenkins --limits=memory=2Gi,cpu=2 --requests=memory=1Gi,cpu=500m -n ${JENKINS_NAMESPACE}

sleep 5

#expose the jenkins service
oc expose svc jenkins -n $JENKINS_NAMESPACE
