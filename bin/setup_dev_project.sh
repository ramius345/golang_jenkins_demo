#!/bin/bash

source namespaces.env

#create the project
oc new-project $GO_APP_1_DEV_NAMESPACE

#Setup the dockerfile build for creating our go container
#setup the container build for the customized nexus container
oc new-build --strategy=docker -D $'FROM scratch\n
   ADD http://nexus.golang-jenkins-demo.svc.cluster.local:8081/repository/binaries/go_app_1/$BUILD_NUMBER/go_app_1 /go_app_1
   USER appuser:appuser\n
   ENTRYPOINT [ "/go_app_1" ]\n
' --name=go-app-1 -n $GO_APP_1_DEV_NAMESPACE


#allow the jenkins namespace to modify things
oc policy add-role-to-user edit system:serviceaccount:$JENKINS_NAMESPACE:jenkins

#run helm
helm install --name-template go-app-1 ../go-app-1-chart

