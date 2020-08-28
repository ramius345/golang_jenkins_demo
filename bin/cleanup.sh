#!/bin/bash

source namespaces.env

oc delete project $JENKINS_NAMESPACE
