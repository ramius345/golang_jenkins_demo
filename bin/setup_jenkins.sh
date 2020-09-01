#!/bin/bash

source namespaces.env

# #create the openshift project/kubernetes namespace
# oc new-project $JENKINS_NAMESPACE

# #instantiate the jenkins perstistent template
# #oc new-app jenkins-persistent  --param MEMORY_LIMIT=2Gi --param VOLUME_CAPACITY=4Gi --param DISABLE_ADMINISTRATIVE_MONITORS=true
# oc new-app jenkins-ephemeral  --param MEMORY_LIMIT=4Gi --param DISABLE_ADMINISTRATIVE_MONITORS=true

# #set the DC resources
# oc set resources dc jenkins --limits=memory=2Gi,cpu=2 --requests=memory=1Gi,cpu=500m -n ${JENKINS_NAMESPACE}


# #setup the build container
# oc new-build --strategy=docker -D $'FROM quay.io/openshift/origin-jenkins-agent-base:4.7.0\n
#    USER root\n
#    RUN rm -f /etc/yum.repos.d/* && \ \n
#    curl https://raw.githubusercontent.com/ramius345/golang_jenkins_demo/master/slave_container/centos.repo -o /etc/yum.repos.d/centos.repo && \ \n
#    yum -y --setopt=tsflags=nodocs install skopeo golang && yum clean all\n
#    RUN mkdir -p /usr/local/bin && \ \n
#    curl https://get.helm.sh/helm-canary-linux-amd64.tar.gz -o /usr/local/bin/helm.tar.gz && \ \n
#    tar -xzvf /usr/local/bin/helm.tar.gz -C /usr/local/bin && \ \n
#    mv /usr/local/bin/linux-amd64/helm /usr/local/bin/helm && \ \n
#    rm -rf /usr/local/bin/linux-amd64\n
#    USER 1001' --name=jenkins-agent-appdev -n $JENKINS_NAMESPACE


# #setup the container build for the customized nexus container
# oc new-build --strategy=docker -D $'FROM sonatype/nexus3:latest\n
#    USER root\n
#    RUN curl -L  https://github.com/ramius345/golang_jenkins_demo/raw/master/nexus_docker_build/nexus-data.tar.gz -o /orig-nexus-data.tar.gz \n
#    RUN curl -L  https://raw.githubusercontent.com/ramius345/golang_jenkins_demo/master/nexus_docker_build/entrypoint.sh -o /entrypoint.sh \n
#    RUN chmod +x /entrypoint.sh\n
#    USER nexus\n
#    ENTRYPOINT [ "/bin/bash" , "-c" , "/entrypoint.sh" ]\n
# ' --name=custom-nexus -n $JENKINS_NAMESPACE


# # [ramius@redgrape bin]$ oc get builds | grep custom-nexus
# # custom-nexus-1           Docker            Dockerfile   Running    About a minute ago
# # [ramius@redgrape bin]$ oc get builds | grep custom-nexus
# # custom-nexus-1           Docker            Dockerfile   Complete   3 minutes ago   1m20s
# # [ramius@redgrape bin]$

# while [ "$(oc get builds | grep custom-nexus | awk '{print $4}')" != "Complete" ]; do
#     sleep 5
#     echo "Waiting for build to complete"
# done

# # Setup the nexus installation utilizing a helm chart
# helm install --name-template nexus ../nexus-chart


# # Setup the go application 1 build
# echo "apiVersion: v1
# items:
# - kind: \"BuildConfig\"
#   apiVersion: \"v1\"
#   metadata:
#     name: \"go-app-1-pipeline\"
#   spec:
#     source:
#       type: \"Git\"
#       git:
#         uri: \"https://github.com/ramius345/golang_jenkins_demo.git\"
#       contextDir: go_app_1
#     strategy:
#       type: \"JenkinsPipeline\"
#       jenkinsPipelineStrategy:
#         jenkinsfilePath: Jenkinsfile
# kind: List
# metadata: []" | oc create -f - -n $JENKINS_NAMESPACE



#Setup the dockerfile build for creating our go container
#setup the container build for the customized nexus container
oc new-build --strategy=docker -D $'FROM scratch\n
   ADD http://nexus.golang-jenkins-demo.svc.cluster.local:8081/repository/binaries/go_app_1/$BUILD_NUMBER/go_app_1 /go_app_1
   USER appuser:appuser\n
   ENTRYPOINT [ "/go_app_1" ]\n
' --name=go-app-1 -n $JENKINS_NAMESPACE
