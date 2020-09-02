#!/bin/bash

source namespaces.env

oc delete project $JENKINS_NAMESPACE
oc delete project $GO_APP_1_DEV_NAMESPACE
