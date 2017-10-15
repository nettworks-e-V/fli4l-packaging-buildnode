FROM starwarsfan/fli4l-packaging:latest
MAINTAINER Yves Schumann <yves@eisfair.org>

# Configuration for Jenkins swarm

# Default values
ARG JENKINS_IP="localhost"
ARG USERNAME="admin"
ARG PASSWORD="admin"
ARG DESCRIPTION="Swarm node for fli4l-packaging"
ARG LABELS="linux swarm fli4l-packaging"
ARG NAME="generic-swarm-node"
ARG UID="1000"

# Environment variables for swarm client
ENV JENKINS_URL=http://$JENKINS_IP \
    JENKINS_USERNAME=$USERNAME \
    JENKINS_PASSWORD=$PASSWORD \
    EXECUTORS=1 \
    DESCRIPTION=$DESCRIPTION \
    LABELS=$LABELS \
    NAME=$NAME

# change user UID
RUN usermod -u ${UID} jenkins

# Start swarm client
ADD "https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.4/swarm-client-3.4.jar" /data/swarm-client.jar
RUN chown jenkins:jenkins /data/ -R
RUN chown jenkins:jenkins /home/jenkins -R

USER jenkins
# Start ssh
#CMD ["/usr/sbin/sshd", "-D"]

CMD java \
    -jar /data/swarm-client.jar \
    -executors "${EXECUTORS}" \
    -noRetryAfterConnected \
    -description "${DESCRIPTION}" \
    -fsroot /data/jenkins-work \
    -master "${JENKINS_URL}" \
    -username "${JENKINS_USERNAME}" \
    -password "${JENKINS_PASSWORD}" \
    -labels "${LABELS}" \
    -name "${NAME}" \
    -sslFingerprints " "
